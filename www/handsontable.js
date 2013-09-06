function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

// data = {}; data[0] = "a"; data[1] = 0; data1 =[data]
// $("#nihao").handsontable({data:data1})

//input binding
$(document).on('click', '.shinyhandsontable', function(){
        var el = $(this);       
        el.trigger("change");
});

var shinyhandsontable = new Shiny.InputBinding();
$.extend(shinyhandsontable, {
        find: function(scope) {
                return $(scope).find(".shinyhandsontable");
        },
        getValue: function(el){
                var myTableArray = [];
                $(el).find("table tr").each(function() {
                    var arrayOfThisRow = [];
                    var tableData = $(this).find('td');
                    if (tableData.length > 0) {
                        tableData.each(function() { arrayOfThisRow.push($(this).text()); });
                        myTableArray.push(arrayOfThisRow);
                    }
                });             
                return myTableArray;
        },
        setValue: function(el, value) {
        },
        subscribe: function(el, callback) {
                $(el).on("change.shinyhandsontable", function(e) {
                        callback();
                });
        },
        unsubscribe: function(el) {
          $(el).off(".shinyhandsontable");
        }
});
Shiny.inputBindings.register(shinyhandsontable);

nihaoma = {};
//output binding
var shinyhandsontableOutput = new Shiny.OutputBinding();
  $.extend(shinyhandsontableOutput, {
    find: function(scope) {
      return $(scope).find('.shinyhandsontable');
    },
    renderValue: function(el, json) {
         //console.log(JSON.parse(data))
         nihaoma = json
      $(el).handsontable( JSON.parse(json)
      // {
        // data: JSON.parse(json)['data'],
        // colHeaders: JSON.parse(json)['colHeaders'],
        // readOnly : true,
        // //startRows: 5,
        // //startCols: 11,       
        // autoWrapRow: false,
        // rowHeaders: true,
        // // colHeaders: true,
        // contextMenu: false,
      //   onChange: function() { $(el).trigger('change');}
      // }
      )
      $(el.trigger('change'))
      ;
    }
  });
Shiny.outputBindings.register(shinyhandsontableOutput, "shinyhandsontable");
