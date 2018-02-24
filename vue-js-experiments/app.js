var demo = new Vue({
  el: '#main',

  data: {
    active: 'home',
    showTooltip: false,
    textContent: 'Edit me.'
  },

  methods: {
    makeActive: function(item) {
      this.active = item;
    },
    hideTooltip: function() {
      this.showTooltip = false;
    }
  }
})
