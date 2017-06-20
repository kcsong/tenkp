/*
Use：
$("#jqGridId").jTableRowSpan("3, 4, 8");
*/
jQuery.fn.jTableRowSpan = function(colIndexs) {
    return this.each(function() {
        var indexs = eval("([" + colIndexs + "])");
        for (var i = 0; i < indexs.length; i++) {
            var that = null;
            $('tbody tr', this).each(function(row) {
                $('td:eq(' + indexs[i] + ')', this).filter(':visible').each(function(col) {
                    if (that != null && $(this).html() == $(that).html()) {
                        rowspan = $(that).attr("rowSpan");
                        if (rowspan == undefined) {
                            $(that).attr("rowSpan", 1);
                            rowspan = $(that).attr("rowSpan");
                        }
                        rowspan = Number(rowspan) + 1;
                        $(that).attr("rowSpan", rowspan);
                        $(this).remove(); // .hide();
                    } else {
                        that = this;
                    }
                    // that = (that == null) ? this : that; // set the that if not already set
                });
            });
        }
    });
};

/*
Use：
$("#jqGridId").jTableColSpan("3, 4, 8");
*/
jQuery.fn.jTableColSpan = function(colIndexs) {
    return this.each(function() {
        var indexs = eval("([" + colIndexs + "])");
        for (var i = 0; i < indexs.length; i++) {
	        var that = null;
	        $('tbody tr:eq(' + indexs[i] + ') td', this).filter(':visible').each(function(row) {
	            if (that != null && $(this).html() == $(that).html()) {
	                colspan = $(that).attr("colSpan");
	                if (colspan == undefined) {
	                    $(that).attr("colSpan", 1);
	                    colspan = $(that).attr("colSpan");
	                }
	                colspan = Number(colspan) + 1;
	                $(that).attr("colSpan", colspan);
	                $(this).remove(); // .hide();
	            } else {
	                that = this;
	            }
	            // that = (that == null) ? this : that; // set the that if not already set
	        });
        }
    });
};
