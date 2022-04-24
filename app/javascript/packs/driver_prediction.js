import { Nameplate } from './formula1_v2'

$(() => {
  $(".drivers-prediction").children().each((_index, item) => {
    const driverInfo = JSON.parse(item.value);
    const driver = {
      "grid": {
        "position": driverInfo.position,
        "state": driverInfo.state
      },
      "color": driverInfo.color,
      "firstname": driverInfo.nickname,
      "lastname": "",
      "team": driverInfo.team,
      "number": driverInfo.score,
      "flag": driverInfo.country.toLowerCase()
    }
    new Nameplate(driver).Create(document.querySelector(".drivers-prediction"));
  })
});
