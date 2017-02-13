var ready = function() {
	$("input#parrafoCB").change(function(){
			
			var parrafoDiv = $(".parrafoDiv")

			if($("input#parrafoCB").is(":checked")){
				parrafoDiv.show();
			}else{
				parrafoDiv.hide();
			}
		}
	);

	$("input#tableCB").change(function(){
			
			var parrafoDiv = $(".tableDiv")

			if($("input#tableCB").is(":checked")){
				parrafoDiv.show();
			}else{
				parrafoDiv.hide();
			}
		}
	);

	$("button#addRow").click(function(){
		var rows_total  = $("#questionTable").find("tr").length;
		var cells_total =  $("#questionTable").find("td").length;

		var cellsPerRow = cells_total / rows_total;

		var new_cells = $("<td>").append($("<input>").attr("type","text"));	
		for(var i=0; i< cellsPerRow-1 ;i++){
			new_cells = new_cells.add($("<td>").append($("<input>").attr("type","text")));
		}

		$("#questionTable").append($("<tr>").append(new_cells));
		return false;
	});
	$("button#eraseRow").click(function(){
		$("#questionTable").find("tr:last").remove();
		return false;
	});
	$("button#addColumn").click(function(){
		console.log(tableToCSV());
		var trs = $("#questionTable").find("tr");
		var rows_total  = trs.length;
		var cells_total =  $("#questionTable").find("td").length;

		for(var i=0; i< rows_total ;i++){
			var row = trs[i];
			var td = $("<td>").append($("<input>").attr("type","text"))
			row.append(td[0]);
		}

		return false;
	});
	$("button#eraseColumn").click(function(){
		var trs = $("#questionTable").find("tr");
		var rows_total  = trs.length;
		for(var i=0; i< rows_total ;i++){
			//var row = trs[i];
			$(trs[i]).find("td:last").remove();
		}
		return false;
	});

	function tableToCSV(){
		var trs = $("#questionTable").find("tr");
		var csv = "";
		trs.each(function(){
			$(this).find("td").each(function(){
				var text = $(this).find("input")[0].value;
				text = text == "" ? "---" : text;
				csv  = csv + text + ",";
			});
			csv = csv.slice(0,-1);//remove last cahr(",")
			csv = csv + "\n";
		});
		return csv;
	}

}
$(document).on('turbolinks:load',ready);
