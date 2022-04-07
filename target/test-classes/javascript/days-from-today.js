function daysFromToday(daysToAdd) {
  Date.prototype.addDays = function (days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
  };

  let dayFromToday = new Date().addDays(daysToAdd);

  var dd = String(dayFromToday.getDate()).padStart(2, "0");
  var mm = String(dayFromToday.getMonth() + 1).padStart(2, "0"); //Janeiro é atribuído como 0!
  var yyyy = dayFromToday.getFullYear();

  return yyyy + "-" + mm + "-" + dd;
}
