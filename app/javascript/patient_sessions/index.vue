<template>
  <div>
    <!-- <b-alert show dismissible variant="danger" v-if="deleteError">
      <p>There was a problem deleting the User. Please try again. If problem persists, please contact Technical Support.</p>
    </b-alert> -->
    <b-alert :show="showSucessMessage"
              dismissible
              fade
              variant="success"
              @dismissed="showSucessMessage=0">
      <p>{{successMessage}}</p>
    </b-alert>
    <b-table id="patient-sessions-table"
             show-empty
             striped
             responsive
             no-provider-paging
             no-provider-sorting
             hover
             :sort-by.sync="sortBy"
             :sort-desc.sync="sortDesc"
             :busy.sync="isBusy"
             :fields="fields"
             :items="patientSessions"
             :current-page="currentPage"
             :per-page="perPage">
      <!-- <template slot="actions" slot-scope="row" >
        <b-button size="sm" variant="link" @click.stop="editUser(row.item)">
          Edit
        </b-button>
        <b-button size="sm" variant="link" @click.stop="bookAppointmentForUser(row.item)">
          Book
        </b-button>
        <b-button size="sm" variant="link" @click.stop="removeUser(row.item, row.index)">
          Remove?
        </b-button>
      </template> -->
    </b-table>
    <b-row>
      <b-col md="6">
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage"/>
      </b-col>
    </b-row>
    <BulkCreatePatientSessionForm></BulkCreatePatientSessionForm>
  </div>
</template>

<script>
  import BulkCreatePatientSessionForm from '../patient_sessions/bulk_create_form.vue'

  export default {
    data () {
      return {
        patientSessions: [],
        sortBy: 'id',
        sortDesc: true,
        fields: [
          { key: 'id', label: 'ID', sortable: true },
          { key: 'date', label: 'Date', sortable: true },
          { key: 'start_time', label: 'Start Time', sortable: true },
          { key: 'end_time', label: 'End Time', sortable: true },
          { key: 'patient_name', label: 'Patient Name', sortable: true },
          { key: 'appointment_id', label: 'Appointment ID', sortable: true },
          { key: 'actions', label: 'Actions', sortable: false }
        ],
        currentPage: 1,
        totalRows: 0,
        perPage: 10,
        pageOptions: [ 5, 10, 15 ],
        deleteError: false,
        showSucessMessage: 0,
        successMessage: '',
        isBusy: false
      }
    },
    components: {
      BulkCreatePatientSessionForm
    },
    mounted () {
      this.getPatientSessions()
    },
    created () {
      this.$eventHub.$on('new-user-added', user => {
        this.addUserToTable(user)
      })

      this.$eventHub.$on('user-updated', user => {
        this.successMessage = `Successfully updated ${user.full_name}`
        this.showSucessMessage = 5 //in seconds
      })

      this.$eventHub.$on('new-appointment', appointment => {
        this.successMessage = `Successfully booked ${appointment.patient_name} on ${appointment.date_and_time}`
        this.showSucessMessage = 10 //in seconds
      })
    },
    beforeDestroy () {
      this.$eventHub.$off('new-user-added')
      this.$eventHub.$off('user-updated')
      this.$eventHub.$off('new-appointment')
    },
    methods: {
      editUser (user) {
        this.$eventHub.$emit('edit-a-user', user)
        this.$root.$emit('bv::show::modal', 'userForm')
      },
      bookAppointmentForUser (user) {
        this.$eventHub.$emit('book-appointment-for-user', user)
        this.$root.$emit('bv::show::modal', 'appointmentForm')
      },
      getPatientSessions () {
        let promise = this.$http.get('/admin/patient_sessions.json')

        return promise.then((data) => {
          const items    = data.body
          this.totalRows = items.length
          this.patientSessions = items
          this.isBusy    = false
        }).catch(error => {
          this.isBusy = false

          return []
        })
      },
      removeUser (user, userIndex) {
        this.deleteError = false
        this.userIndex   = userIndex
        var dontDelete   = !(confirm(`Really delete ${user.full_name}?`))

        if (dontDelete) {
          return;
        }

        let promise = this.$http.delete(`/admin/users/${user.id}.json`)

        return promise.then((data) => {
          this.successMessage = 'Successfully removed user!'
          this.showSucessMessage = 5 //in seconds
          this.$delete(this.users, this.userIndex)
        }).catch(error => {
          this.deleteError = true
        })
      },
      addUserToTable (user) {
        this.successMessage = `Successfully added ${user.full_name}`
        this.showSucessMessage = 5 //in seconds
        this.users.push(user)
      }
    }
  }
</script>
