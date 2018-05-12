// Cookies

function getCookie(cname)
{
var name = cname + "=";
var ca = document.cookie.split(';');
for(var i=0; i<ca.length; i++)
  {
  var c = ca[i].trim();
  if (c.indexOf(name)==0) return c.substring(name.length,c.length);
}
return "";
}


////
var last_state=new Array();
var last_state_count=0;

function openBox(outerid,innerid,url,qs)
{
	//window.open(url+'?'+qs,'', 'height=400,width=600')
	$("#"+outerid).css("visibility","visible");
	$.post(url,qs,
	function(data,status)
	{
		$("#"+innerid).html(data);
	}
	);
	return false;
}

function closeBox(outerid,innerid)
{
	last_state_count=0;
	$("#"+outerid).css("visibility","hidden");
	$("#"+innerid).html("<center><br><br><img src=\"images/loading.gif\"><br><br><h3>Loading...</h3></center>");
}

function loadBox(url,qs)
{
	last_state.push($("#extra_inner_box").html());
	last_state_count++;
	$("#extra_box_back_button").css("visibility","visible");
	$("#extra_inner_box").html("<center><br><br><img src=\"images/loading.gif\"><br><br><h3>Loading...</h3></center>");
	$("#extra_inner_box").load(url,qs);
	return false;
}


$(document).ready(function(){
$("#extra_box_back_button").click(function(){
	last_state_count--;
	if(last_state_count==0)
	{
		$("#extra_box_back_button").css("visibility","hidden");
	}
	$("#extra_inner_box").html(last_state.pop());
});
});

function loadSearchBox(url,qs)
{
	last_state.push($("#search_inner_box").html());
	last_state_count++;
	$("#search_box_back_button").css("visibility","visible");
	$("#search_inner_box").html("<center><br><br><img src=\"images/loading.gif\"><br><br><h3>Loading...</h3></center>");
	$("#search_inner_box").load(url,qs);
	return false;
}

$(document).ready(function(){
$("#search_box_back_button").click(function(){
	last_state_count--;
	if(last_state_count==0)
	{
		$("#search_box_back_button").css("visibility","hidden");
	}
	$("#search_inner_box").html(last_state.pop());
});
});
