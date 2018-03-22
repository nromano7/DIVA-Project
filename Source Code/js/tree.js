
function render_tree(treeData, size, margin) {

  // dimensions and margins
  var duration = 1000; // load duration (ms)
   
  var root,
    width = size.width - margin.right - margin.left,
    height = size.height - margin.top - margin.bottom;


  // append svg element to body and group element to svg
  var svg = d3.select("#tree")
    .append("svg")
    .attr("id","tree_svg")
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  // Create empty tree layout with spcified  height and width
  var treemap = d3.tree().size([height, width]);

  // Assigns parent, children, height, depth
  root = d3.hierarchy(treeData, function (d) {
    return d.children;
  });
  root.x0 = height / 2;
  root.y0 = 0;

//create array of node sizes based on number of descendants
  function nodeSize(d) {
      var radii = [],
          numNodes = d.length;
      for (let i = 0; i < d.length; i++) {
          if (d[i].hasOwnProperty("children") && d[i].children != null) {
              var numChildren = d[i].children.length;
              radii.push(10 * Math.sqrt(numChildren));
          } else if(d[i].hasOwnProperty("_children") && d[i]._children != null){
          	var numChildren = d[i]._children.length;
              radii.push(10 * Math.sqrt(numChildren));
          } else {
              radii.push(10);
          }
      }
      return radii;
  }
  var r = nodeSize(root.descendants());

  // Collapse after the second level
  root.children.forEach(collapse);

  render(root);

  // Collapse the node and all it's children
  function collapse(d) {
    if (d.children) {
      d._children = d.children
      d._children.forEach(collapse)
      d.children = null
    }
  }

  var id=0;

  function render(source) {

    // layout root hierarchy
    var treeData = treemap(root);

    // Compute the new tree layout.
    var nodes = treeData.descendants(),
      links = treeData.descendants().slice(1);

    var r = nodeSize(nodes);
    // Normalize for fixed-depth.
    nodes.forEach(function (d, j) {
      d.y = d.depth * 180
      d.r = r[j]
    });

    // ENTER ------------------------------------
    // update the nodes...
    var node = svg.selectAll('g.node')
      .data(nodes, function (d) {
        return d.id || (d.id = ++id);
      });

    // enter any new nodes at the parent's previous position.
    var nodeEnter = node.enter().append('g')
      .attr('class', function (d) {
        return d.parent ? "node" : "fake";
      })
      .attr("transform", function (d) {
        return "translate(" + source.y0 + "," + source.x0 + ")";
      })
      .on('click', click);

    // add circles for nodes
    nodeEnter.append('circle')
      .attr('class', function (d) {
        return d.parent ? "node" : "fake";
      })
      .attr('r', function (d) {
        return d.r;
      })
      .style("fill", function (d) {
        return d._children ? "lightsteelblue" : "#fff";
      });

    // add labels for the nodes
    nodeEnter.append('text')
        .attr("dy", ".35em")
        .attr("x", function (d) {
            return d.children || d._children ? -1*d.r - 35 : -1*d.r + 35;
        })
        //.attr("y", function (d) {
        //    return d.children || d._children ? d.r + 10 : 0;
        //})
        .attr("text-anchor", function (d) {
            return d.children || d._children ? "middle" : "start";
        })
        .text(function (d) {
            return d.data.name;
        });

    // update the links...
    var link = svg.selectAll('path.link')
      .data(links, function (d) {
        return d.id;
      });

    // enter any new links at the parent's previous position.
    var linkEnter = link.enter().insert('path', "g")
      .attr("class", function (d) {
        return (d.data.parent=="top level") ? "fake" : "link";
      })
      .attr('d', function (d) {
        var o = {
          x: source.x0,
          y: source.y0
        }
        return diagonal(o, o)
      });

    // UPDATE ---------------------------------------
    var nodeUpdate = nodeEnter.merge(node);

    // Transition to the proper position for the node
    nodeUpdate.transition()
      .duration(duration)
      .attr('class', function (d) {
        return d.parent ? "node" : "fake";
      })
      .attr("transform", function (d) {
        return "translate(" + d.y + "," + d.x + ")";
      });

    // Update the node attributes and style
    nodeUpdate.select('circle.node')
      .attr('r', function (d) {
        return d.r;
      })
      .style("fill", function (d) {
        return d._children ? "lightsteelblue" : "#fff";
      })
      .attr('cursor', 'pointer');

    var linkUpdate = linkEnter.merge(link);

    // Transition back to the parent element position
    linkUpdate.transition()
      .duration(duration)
      .attr("class", function (d) {
        return (d.data.parent=="top level") ? "fake" : "link";
      })
      .attr('d', function (d) {
        return diagonal(d, d.parent)
      });

    // EXIT -------------------------------------------
    // Remove any exiting nodes
    var nodeExit = node.exit().transition()
      .duration(duration)
      .attr("transform", function (d) {
        return "translate(" + source.y + "," + source.x + ")";
      })
      .remove();

    // On exit reduce the node circles size to 0
    nodeExit.select('circle')
      .attr('r', 1e-6);

    // On exit reduce the opacity of text labels
    nodeExit.select('text')
      .style('fill-opacity', 1e-6);

    // remove any exiting links
    var linkExit = link.exit().transition()
      .duration(duration)
      .attr('d', function (d) {
        var o = {
          x: source.x,
          y: source.y
        }
        return diagonal(o, o)
      })
      .remove();

    // Store the old positions for transition.
    nodes.forEach(function (d) {
      d.x0 = d.x;
      d.y0 = d.y;
    });

    // Creates a curved (diagonal) path from parent to the child nodes
    // s = source, d = destination
    function diagonal(s, d) {

      path =
        `M ${s.y} ${s.x}
          C ${(s.y + d.y) / 2} ${s.x},
            ${(s.y + d.y) / 2} ${d.x},
            ${d.y} ${d.x}`

      return path
    }

    // Toggle children on click.
    function click(d) {
      if (d.children) {
        d._children = d.children;
        d.children = null;
      } else {
        d.children = d._children;
        d._children = null;
      }
      render(d);
    }
  }

  return svg

}