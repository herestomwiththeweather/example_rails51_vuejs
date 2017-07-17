<template>
<table>
  <thead>
    <tr>
      <th colspan="4"></th>
    </tr>
  </thead>

  <tbody>
    <tr is="employee-row" v-for="employee in employees" :employee="employee">
    </tr>
    <tr>
      <td>
	<input type="text" v-model="employee.name"><br>
	<span style="color:red">{{ errors.name }}</span>
      </td>
      <td>
	<input type="text" v-model="employee.email"><br>
	<span style="color:red">{{ errors.email }}</span>
      </td>
      <td><input type="checkbox" v-model="employee.manager"></td>
      <td><button @click="hireEmployee">Hire</button></td>
    </tr>
  </tbody>
</table>
</template>

<script>

export default {
  data: function () {
    return {
      employees: [],
      employee: {
	name: '',
	email: '',
	manager: false
      },
      errors: {}
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
  },
  methods: {
    hireEmployee: function () {
      var that = this;
      $.ajax({
	method: 'POST',
	data: {
	  employee: that.employee
	},
	url: '/employees.json',
	success: function(res) {
	  that.errors = {};
	  that.employees.push(res);
	},
	error: function(res) {
	  that.errors = res.responseJSON.errors;
	}
      });
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
