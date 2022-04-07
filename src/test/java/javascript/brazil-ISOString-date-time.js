function brazilDateTime() {
  let todayISO = new Date().toISOString();
  let brazil_time = new Date().toLocaleTimeString("pt-BR");
  let brazil_date_time =
    todayISO.slice(0, 10) + "T" + brazil_time + todayISO.slice(19, 24);
  return brazil_date_time;
}
