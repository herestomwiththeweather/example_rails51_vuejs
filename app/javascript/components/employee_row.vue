<template>
<tr>
  <td>
    <div v-if="editMode">
      <input type="text" v-model="employee.name"><br>
      <span style="color:red">{{ errors.name }}</span>
    </div>
    <div v-else>{{ employee.name }}</div>
  </td>
  <td>
    <div v-if="editMode">
      <input type="text" v-model="employee.email"><br>
      <span style="color:red">{{ errors.name }}</span>
    </div>
    <div v-else>{{ employee.email }}</div>
  </td>
  <td>
    <div v-if="editMode">
      <input type="checkbox" v-model="employee.manager">
    </div>
    <div v-else>{{ employee.manager ? '&#10004;' : '' }}</div>
  </td>
  <td>
    <button v-if="editMode" @click="updateEmployee">Save</button>
    <button v-else @click="editMode = true">Edit</button>
    <button v-if="!editMode" @click="toggleManagerStatus">{{ employee.manager ? 'Demote' : 'Promote' }}</button>
    <button v-if="!editMode" @click="fireEmployee" style="color:red">Fire</button>
  </td>
</tr>
</template>
<script>
export default {
  name: 'employee-row',
  props: {
    employee: Object
  },
  data: function () {
    return {
      editMode: false,
      errors: {}
    }
  },
  methods: {
    toggleManagerStatus: function () {
      this.employee.manager = !this.employee.manager;
      this.updateEmployee();
    },
    updateEmployee: function () {
      var that = this;
      $.ajax({
	method: 'PUT',
	data: {
	  employee: that.employee
	},
	url: '/employees/' + that.employee.id + '.json',
	success: function(res) {
	  that.errors = {};
	  that.employee = res;
	  that.editMode = false;
	},
	error: function(res) {
	  that.errors = res.responseJSON.errors;
	}
      });
    },
    fireEmployee: function () {
      var that = this;
      $.ajax({
	method: 'DELETE',
	url: '/employees/' + that.employee.id + '.json',
	success: function(res) {
	  that.$el.remove();
	},
	error: function(res) {
	  that.errors = res.responseJSON.errors
	}
      })
    }
  }
}
</script>
