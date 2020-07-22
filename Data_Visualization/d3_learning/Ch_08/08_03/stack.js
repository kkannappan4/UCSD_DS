var parseDate = d3.timeParse("%Y");

d3.xml("data2.xml").get(function(error,xml){

  var height = 200;
  var width = 500;
  var margin = {left: 50, right: 50, top: 40, bottom:0};

  xml = [].map.call(xml.querySelectorAll("dat"),function(d){
    return {
      date: parseDate(d.getAttribute("id")),
      top: +d.querySelector("top").textContent,
      middle: +d.querySelector("middle").textContent,
      bottom: +d.querySelector("bottom").textContent

    };

  })
  var x = d3.scaleTime()
            .domain(d3.extent(xml,function(d){return d.date;}))
            .range([0,width]);
  var y = d3.scaleLinear()
            .domain([0,d3.max(xml,function(d){ return d.top+d.middle+d.bottom; })])
            .range([height,0]);

  var categories = ['top','middle','bottom'];

  var stack = d3.stack().keys(categories);

  var area = d3.area()
                .x(function(d,i){ return d.data.date;})
                .y0(function(d){ return y(d[0]);})
                .y1(function(d){ return y(d[1]);});

  var svg = d3.select("body").append("svg").attr("width","100%").attr("height","100%");
  var chartGroup = svg.append("g").attr("transform","translate("+margin.left+","+margin.top+")");

  var stacked = stack(xml);
















});
