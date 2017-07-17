<template>
<tr>
  <td>{{employee.name}}</td>
  <td>{{employee.email}}</td>
  <td>{{employee.manager}}</td>
</tr>
</template>
<script>
export default {
  name: 'employee-row',
  props: {
    employee: Object
  }
}
</script>
