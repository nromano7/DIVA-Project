function update_apps_table() {
  var ret = '<table><tr><th id="app_sort1">Application_ID</th><th id="s_sort1">' +
    'Student_ID</th><th id="p_sort1">Professor_ID</th>' +
    '<th id="c_sort1">Course_ID</th></tr>';
  for (let i = 0; i < a_list.length; i++) {
    ret += '<tr>';
    for (let j = 0; j < a_list[i].length; j++) {
      ret += '<th>' + a_list[i][j] + '</th>';
    }
    ret += '</tr>';
  }
  ret += '</table>';
  return ret;
}

function addListenersToApps() {
  document.getElementById("app_sort1").addEventListener("click", function () {
    a_list.sort(function (a, b) {
      return a[0].localeCompare(b[0]);
    });
    document.getElementById("apps_table").innerHTML = update_apps_table();
    addListenersToApps();
  });
  document.getElementById("s_sort1").addEventListener("click", function () {
    a_list.sort(function (a, b) {
      return a[1].localeCompare(b[1]);
    });
    document.getElementById("apps_table").innerHTML = update_apps_table();
    addListenersToApps();
  });
  document.getElementById("p_sort1").addEventListener("click", function () {
    a_list.sort(function (a, b) {
      return a[2].localeCompare(b[2]);
    });
    document.getElementById("apps_table").innerHTML = update_apps_table();
    addListenersToApps();
  });
  document.getElementById("c_sort1").addEventListener("click", function () {
    a_list.sort(function (a, b) {
      return a[3].localeCompare(b[3]);
    });
    document.getElementById("apps_table").innerHTML = update_apps_table();
    addListenersToApps();
  });
}

function update_matching_table() {
  var ret = '<table><tr><th id="app_sort">Application_ID</th><th id="s_sort">' +
    'Student_ID</th><th id="p_sort">Professor_ID</th>' +
    '<th id="c_sort">Course_ID</th></tr>';
  for (let i = 0; i < matches.length; i++) {
    ret += '<tr>';
    for (let j = 0; j < matches[i].length; j++) {
      ret += '<th>' + matches[i][j] + '</th>';
    }
    ret += '</tr>';
  }
  ret += '</table>';
  return ret;
}

function addListenersToMatches() {
  document.getElementById("app_sort").addEventListener("click", function () {
    matches.sort(function (a, b) {
      return a[0].localeCompare(b[0]);
    });
    document.getElementById("matches_table").innerHTML = update_matching_table();
    addListenersToMatches();
  });
  document.getElementById("s_sort").addEventListener("click", function () {
    matches.sort(function (a, b) {
      return a[1].localeCompare(b[1]);
    });
    document.getElementById("matches_table").innerHTML = update_matching_table();
    addListenersToMatches();
  });
  document.getElementById("p_sort").addEventListener("click", function () {
    matches.sort(function (a, b) {
      return a[2].localeCompare(b[2]);
    });
    document.getElementById("matches_table").innerHTML = update_matching_table();
    addListenersToMatches();
  });
  document.getElementById("c_sort").addEventListener("click", function () {
    matches.sort(function (a, b) {
      return a[3].localeCompare(b[3]);
    });
    document.getElementById("matches_table").innerHTML = update_matching_table();
    addListenersToMatches();
  });
}

document.getElementById("clickMe").addEventListener("click", function () {
      var temp = [];
      for (let i = 0; i < 20; i++) {
        temp = generateMatching(s_list, p_list, c_list, a_list, priority_list);
        if (temp.length >= matches.length)
          matches = temp.slice();
      }
      document.getElementById("matches").innerHTML = matches.length;
      document.getElementById("matches_table").innerHTML = update_matching_table();
      addListenersToMatches();