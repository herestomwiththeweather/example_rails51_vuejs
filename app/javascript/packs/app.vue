<template>
<table>
  <thead>
    <tr>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <tr v-for="employee in employees">
      <td>{{employee.name}}</td>
      <td>{{employee.email}}</td>
      <td>{{employee.manager}}</td>
    </tr>
  </tbody>
</table>
</template>

<script>
export default {
  data: function () {
    return {
      employees: []
    }
  },
  mounted: function() {
    var that;
    that = this;
    $.ajax({
      url: '/employees.json',
      success: function(res) {
	that.employees = res;
      }
    });
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
