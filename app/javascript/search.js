$(document).ready(function () {
  $("#submit-btn").on("click", function (event) {
    event.preventDefault();
    const searchval = $("#search").val();
    searchData = {
      query: searchval,
    };
    $.ajax({
      url: "http://localhost:3000/search_buildings",
      type: "GET",
      data: searchData,
      success: function (response) {
        console.log(response);
        $("#result-div").empty();
        $("#result-div").html(response);
      },
      error: function (xhr, status, error) {
        console.error("Error:", error); // Log any errors
      },
    });
  });
});

$(document).ready(function () {
  $("#filter-btn").on("click", function (event) {
    event.preventDefault();
    const filterval = $("#filter-select").val();
    const roomVal = $("#room-select").val();
    const categoryVal = $("#category-select").val();
    filterData = {
      query: filterval,
      room_query : roomVal,
      category_query : categoryVal,
    };
    $.ajax({
      url: "http://localhost:3000/filter_buildings",
      type: "GET",
      data: filterData,
      success: function (response) {
        console.log(response);
        $("#result-div").empty();
        $("#result-div").html(response);
      },
      error: function (xhr, status, error) {
        console.error("Error:", error); // Log any errors
      },
    });
  });
});


