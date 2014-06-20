export default DS.RESTAdapter.extend({
  host : '@@CANARYD_BASE_URL@@',
  namespace : 'checks',
  findQuery: function(store, type, query) {
    var url = this.buildURL('');
    url += "/" + query.check_id + "/measurements" + "?range=150";
    return this.ajax(url, 'GET', { });
  }
});
