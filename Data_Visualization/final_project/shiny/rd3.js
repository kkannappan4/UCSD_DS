// !preview r2d3 data=c(0.3, 0.6, 0.8, 0.95, 0.40, 0.20)
//
// r2d3: https://rstudio.github.io/r2d3
//

var linecolour = "#ffffff";   
var fillcolour = "#A1C349";

var dimX = 120;
var dimY = 53.3;

var holder = d3.select("body") // select the 'body' element
      .append("svg")           // append an SVG element to the body
      .attr("id", "field")
	  .attr("width", 1300)      
      .attr("height", 633);

function range(start, end, step = 1) {
  const allNumbers = [start, end, step].every(Number.isFinite);
    if (!allNumbers) {
        throw new TypeError('range() expects only finite numbers as arguments.');
    }
    if (step <= 0) {
        throw new Error('step must be a number greater than 0.');
    }
    if (start > end) {
        step = -step;
    }
  const length = Math.floor(Math.abs((end - start) / step)) + 1;
return Array.from(Array(length), (x, index) => start + index * step);
}

var incFieldArray = range(10,100,5);
			  

    
// Total Grass    
holder.append("rect")        // attach a rectangle
    .attr("x", 0)         // position the left of the rectangle
    .attr("y", 0)          // position the top of the rectangle
    .attr("height", 633)    // set the height
    .attr("width", 1300)    // set the width
    .style("fill", fillcolour);   // set the fill colour    

// draw a rectangle pitch outline    
holder.append("rect")        // attach a rectangle
    .attr("x", 50)         // position the left of the rectangle
    .attr("y", 50)          // position the top of the rectangle
    .attr("height", 533)    // set the height
    .attr("width", 1200)    // set the width
    .style("stroke-width", 5)    // set the stroke width
    .style("stroke", linecolour)   // set the line colour
    .style("fill", fillcolour);    // set the fill colour     

// draw a rectangle - end zone 1
holder.append("rect")        // attach a rectangle
    .attr("x", 50)         // position the left of the rectangle
    .attr("y", 50)          // position the top of the rectangle
    .attr("height", 533)    // set the height
    .attr("width", 100)    // set the width
    .style("stroke-width", 5)    // set the stroke width
    .style("stroke", linecolour)   // set the line colour
    .style("fill", "none");    // set the fill colour 


// draw a rectangle - end zone 2
holder.append("rect")        // attach a rectangle
    .attr("x", 1150)         // position the left of the rectangle
    .attr("y", 50)          // position the top of the rectangle
    .attr("height", 533)    // set the height
    .attr("width", 100)    // set the width
    .style("stroke-width", 5)    // set the stroke width
    .style("stroke", linecolour)    // set the line colour
    .style("fill", "none");    // set the fill colour

// get yard-lines:
holder.selectAll("line")
      .data(incFieldArray)
      .enter().append("line")
                .attr("x1",function(d,i){ return 100+ (d*10); })
                .attr("stroke-width",function(d,i){ if(i%2 !==0) {return "2px"} else {return "1px"}})
                .attr("stroke",linecolour)
                .attr("y1",50)
                .attr("x2",function(d,i){ return 100+ (d*10);  })
                .attr("y2",583);

// Add NFL SVG Logo in the center of the field
holder.append("g").append("svg:image")
    .attr("xlink:href", "https://logotyp.us/file/nfl.svg")
    .attr("width", 100)
    .attr("height", 100)
    .attr("x", 600)
    .attr("y",266);
