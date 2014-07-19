@baseControllers.controller "AdminDashboardCtrl", [
  "$scope"
  "$http"
  ($scope, $http) ->
    width = $("#user_distribution").width()
    height = width
    radius = Math.min(width, height) / 2
    color = d3.scale.ordinal().range([
      "#98abc5"
      "#8a89a6"
      "#7b6888"
      "#6b486b"
      "#a05d56"
      "#d0743c"
      "#ff8c00"
    ])
    arc = d3.svg.arc().outerRadius(radius - 10).innerRadius(0)
    pie = d3.layout.pie().sort(null).value((d) ->
      d.users_count
    )
    svg = d3.select("#user_distribution").append("svg").attr("width", width).attr("height", height).append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
    promise = $http.get("/api/admin/roles")
    promise.success (data, status, headers, config) ->
      data.forEach (d) ->
        d.users_count = +d.users_count
        return

      g = svg.selectAll(".arc").data(pie(data)).enter().append("g").attr("class", "arc")
      g.append("path").attr("d", arc).style "fill", (d) ->
        color d.data.id

      g.append("text").attr("transform", (d) ->
        "translate(" + arc.centroid(d) + ")"
      ).attr("dy", ".35em").style("text-anchor", "middle").text (d) ->
        d.data.name + " (" + d.data.users_count + ")"

      return
]
