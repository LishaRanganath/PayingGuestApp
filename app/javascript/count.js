$(document).on("click", "#activate_button", function() {
    $.ajax({
      url: "<%= url_for(controller: :home, action: :index, format: :json) %>",
      type: "GET",
      dataType: "json",
      success: function(response) {
        $("#deactive_owners_count h6").text(response.deactive_count);
        $("#active_owners_count h6").text(response.active_count);
      },
      error: function(xhr, status, error) {
        console.error("Error:", error);
      }
    });
  });
  
  $(document).on("click", "#deactivate_button", function() {
    $.ajax({
      url: "<%= url_for(controller: :home, action: :index, format: :json) %>",
      type: "GET",
      dataType: "json",
      success: function(response) {
        $("#deactive_owners_count h6").text(response.deactive_count);
        $("#active_owners_count h6").text(response.active_count);
      },
      error: function(xhr, status, error) {
        console.error("Error:", error);
      }
    });
  });
  