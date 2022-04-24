import { Nameplate } from './formula1_v2'

$(() => {
  $(".prediction-leaderboard").children().each((index, item) => {
    const playerInfo = JSON.parse(item.value);
    const player = {
      "grid": {
        "position": index + 1,
        "state": "ontrack"
      },
      "color": playerInfo.color,
      "firstname": playerInfo.nickname,
      "lastname": "",
      "team": playerInfo.team,
      "number": playerInfo.score,
      "flag": playerInfo.country.toLowerCase()
    }
    new Nameplate(player).Create(document.querySelector(".prediction-leaderboard"));
  })
});
