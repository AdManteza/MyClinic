<template>
  <ul class="navbar-nav mr-auto">
    <li class="nav-item">
      <a href="/admin_dashboard" v-bind:class="{ active: currentPage === '/admin_dashboard' }" class="nav-link">Dashboard</a>
    </li>
    <li class="nav-item">
      <a href="/admin/users" v-bind:class="{ active: currentPage === '/admin/users' }" class="nav-link">Patients</a>
    </li>
    <li class="nav-item">
      <a href="/admin/patient_sessions" v-bind:class="{ active: currentPage === '/admin/patient_sessions' }" class="nav-link">Patient Sessions</a>
    </li>
    <li class="nav-item">
      <a href="/admin/appointments" v-bind:class="{ active: currentPage === '/admin/appointments' }" class="nav-link">Appointments</a>
    </li>
  </ul>
</template>
<script>
  export default {
    props: ['currentPage']
  }
</script>
