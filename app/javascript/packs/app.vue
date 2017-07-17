<template>
<table>
  <thead>
    <tr>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <tr is="employee-row" v-for="employee in employees" :employee="employee">
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
