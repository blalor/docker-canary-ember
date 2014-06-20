export default DS.RESTAdapter.extend({
  buildURL: function(){
    return "@@CHECKS_URL@@";
  }
});
