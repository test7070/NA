<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			q_tables = 't';
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtComp','txtProduct','txtWorker','txtWorker2','txtNotv','txtC1','txtOrdeno','txtNo2','textInano','txtSpec','txtMedate','textScolor','txtUnit','txtItype','txtEdate','txtM8','txtM2'];
			var q_readonlys = ['txtOrdeno', 'txtNo2','txtMo','txtW01','txtProductno2','txtProduct2','txtHmount','txtX01','txtX02','txtX03','txtX04'];
			var q_readonlyt = [];
			var bbmNum = [['txtMount',10,0,1],['txtNotv',10,0,1]];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 10;
			q_copy=1;
			aPop = new Array(
				['txtOrdeno', '', 'view_ordes', 'noa,no2,productno,product,spec,mount,custno,comp,memo', 'txtOrdeno,txtNo2,txtProductno,txtProduct,txtSpec,txtMount,txtCustno,txtComp,txtMemo', ''],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,comp,tel,invoicetitle', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtProductno', 'lblProduct', 'uca', 'noa,product,unit', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
				['txtTggno_', '', 'tgg', 'noa,nick', 'txtTggno_,txtTgg_', ""],
				['txtProcessno_', 'btnProcessno_', 'station', 'noa,station', 'txtProcessno_,txtProcess_', 'station_b.aspx'],
				//['txtProductno2_', '', 'mech', 'noa,mech', 'txtProductno2_,txtProduct2_', 'mech_b.aspx'],
				['txtProductno__', 'btnProductno__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx'],
				['txtStoreno__', 'btnStoreno__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx']
				,['textCugtbstationno', '', 'station', 'noa,station', 'textCugtbstationno', ''],['textCugtestationno', '', 'station', 'noa,station', 'textCugtestationno', '']
				,['txtStyle__', 'btnStyle__', 'style', 'noa,product', 'txtStyle__', 'style_b.aspx']
				,['txtM7', 'lblM7', 'style', 'noa,product', 'txtM7,txtM8', 'style_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {
					
				}
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMedate', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				
				bbmNum = [['txtMount',10,q_getPara('vcc.mountPrecision'),1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtNotv',10,q_getPara('vcc.mountPrecision'),1]];
				bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtW02', 15, 0, 1],['txtW01', 15, 0, 1],['txtW03', 4, 0, 1],['txtHmount', 5, 2, 1]
				,['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1],['txtWmount', 15, q_getPara('vcc.mountPrecision'), 1]];
				bbtNum = [['txtGmount', 15, q_getPara('vcc.mountPrecision'), 1],['txtGweight', 15, q_getPara('vcc.weightPrecision'), 1],['txtHard', 15, 0, 1]];
				q_mask(bbmMask);
				
				q_cmbParse("cmbTypea", 'M@M.一般鋼管,S@S.代工鋼管,K@K.樣品,D@D.研發,V@V.越南生產');
				
				document.title='連續製令單'
				
				$('#btnOrdes').click(function() {
					if(q_cur==1 || q_cur==2){
						var t_custno = trim($('#txtCustno').val());
						var t_noa = trim($('#txtNoa').val());
						var t_where = '';
						t_where = " isnull(a.enda,0)!=1 and isnull(a.cancel,0)!=1";
						t_where += " and not exists(select * from view_cub where ordeno=a.noa and no2=a.no2 and noa!='"+t_noa+"') ";//已匯入 105/05/03
						
						if (t_custno.length > 0) {
							t_where += " and a.custno='"+t_custno+"'";
						}
						
						if (!emp($('#txtOrdeno').val()))
							t_where += " and charindex(a.noa,'" + $('#txtOrdeno').val() + "')>0 ";
						t_where = t_where;
						q_box("ordes_b_na.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
					}
				});
				
				$('#txtMo').change(function() {
					if(dec($('#txtMount').val())!=0 && dec($('#txtMo').val())!=0){
						$('#txtPrice').val(round(q_div(dec($('#txtMo').val()),dec($('#txtMount').val())),q_getPara('vcc.pricePrecision')));
					}
				});
				
				$('#txtMount').change(function() {
					$('#txtMo').val(round(q_mul(dec($('#txtMount').val()),dec($('#txtPrice').val())),0));
				});
				
				$('#txtPrice').change(function() {
					$('#txtMo').val(round(q_mul(dec($('#txtMount').val()),dec($('#txtPrice').val())),0));
				});
				
				$('#textInano').click(function() {
					if(!emp($('#textInano').val())){
						var t_where="1=1 and charindex(noa,'"+$('#textInano').val()+"')>0 "
						q_box("inafe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'inafe', "95%", "650px", '入庫單');
					}
				});
				
				$('#btnCubu_na').click(function() {
					if (q_cur == 0 || q_cur==4) {
						if($('#txtNoa').val().length>0){
							var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
							q_box("cubu_b_na.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
						}
					}
				});
				
				$('#btnCugt2').click(function() {
					$('#textCugtbdate').val(q_date());
					$('#textCugtedate').val(q_cdn(q_date(),15));
					$('#textCugtbstationno').val('');
					$('#textCugtestationno').val('');
					$('#textCugtGen').val('');
					if(q_getPara('sys.saturday').toString()=='1')
						$('#checkSaturday').prop('checked','true')
					else
						$('#checkSaturday').prop('checked','')
					$('#checkSunday').prop('checked','')
					
					$('#div_cugt').css('top', $('#btnCugt2').offset().top+25);
					$('#div_cugt').css('left', $('#btnCugt2').offset().left-$('#div_cugt').width()+$('#btnCugt2').width()+10);
					$('#div_cugt').toggle();
					q_cur=2;
				});
				
				$('#btn_div_cugt').click(function() {
					if(emp($('#textCugtbdate').val()) || emp($('#textCugtedate').val())){
						alert('請填寫日期區間!!');
						return;
					}
					
					if(emp($('#textCugtbstationno').val()) && emp($('#textCugtestationno').val())){
						if(!confirm("確定要更新全部的製程?"))
							return;
					}
					
					if(dec($('#textCugtGen').val())<=0){
						if(dec($('#textCugtGen').val())<0){
							alert('請填寫正確產能!!');
							return;
						}else{
							if(!confirm("確定要將產能設置成0?"))
								return;	
						}
					}
					
					var t_week='';
					if(!$('#div_cugtweek').is(':hidden')){
						$('#div_cugtweek input[type="checkbox"]').each(function(){
							if($(this).prop('checked'))
								t_week+=$(this).val()+'^';
						});
					}
					
					if(t_week=='')
						t_week='#non';
					
					var t_cugt_bstationno=!emp($('#textCugtbstationno').val())?trim($('#textCugtbstationno').val()):'#non';
					var t_cugt_estationno=!emp($('#textCugtestationno').val())?trim($('#textCugtestationno').val()):'#non';
					var t_cugt_bstationgno=!emp($('#textCugtbstationgno').val())?trim($('#textCugtbstationgno').val()):'#non';
					var t_cugt_estationgno=!emp($('#textCugtestationgno').val())?trim($('#textCugtestationgno').val()):'#non';
					var t_cugt_bdate=!emp($('#textCugtbdate').val())?trim($('#textCugtbdate').val()):'#non';
					var t_cugt_edate=!emp($('#textCugtedate').val())?trim($('#textCugtedate').val()):'#non';
					var t_cugt_saturday=$('#checkSaturday').prop('checked')?'1':'#non';
					var t_cugt_sunday=$('#checkSunday').prop('checked')?'1':'#non';
					var t_cugt_gen=dec($('#textCugtGen').val()).toString();
					
					$('#btn_div_cugt').attr('disabled', 'disabled');
					$('#btn_div_cugt').val('更新中....');
					q_func('qtxt.query.cugtchange', 'cug.txt,cugtchange,'+t_cugt_bstationno+';'+t_cugt_estationno+';'+t_cugt_bstationgno+';'+t_cugt_estationgno
					+';'+t_cugt_bdate+';'+t_cugt_edate+';'+t_cugt_saturday+';'+t_cugt_sunday+';'+t_cugt_gen+';'+t_week+';'+r_name+';'+r_len);
					q_cur=0;
					$('#div_cugtweek').hide();
				});
				
				$('#btnClose_div_cugt').click(function() {
					q_cur=0;
					$('#div_cugt').toggle();
					$('#div_cugtweek').hide();
				});
				
				$('#btn_div_cugtweek').click(function() {
					$('#div_cugtweek').show();
					//產生勾選日期
					var week_bdate=$('#textCugtbdate').val();
					var week_edate=$('#textCugtedate').val();
					
					if(week_bdate=='' && week_edate==''){
						week_bdate=q_date();
						week_edate=q_cdn(q_date(),13);
					}else if(week_bdate!='' && week_edate==''){
						week_edate=q_cdn(week_bdate,13);
					}else if(week_bdate=='' && week_edate!=''){
						week_bdate=q_cdn(week_edate,-13);
					}
					
					$('#div_cugtweek').css('top', $('#div_cugt').offset().top+$('#div_cugt').height()+5);
					$('#div_cugtweek').css('left', $('#div_cugt').offset().left);
					
					var tmp_checkbox='',t_week=1;
					if(q_holiday==undefined)
						q_holiday=[];
					while(week_bdate<=week_edate){
						if(q_holiday.indexOf(week_bdate)>-1 || getweek(week_bdate)=='日' || (getweek(week_bdate)=='六' && q_getPara('sys.saturday').toString()=='0'))
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' style='color:red;'>" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						else{
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' >" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						}
						week_bdate=q_cdn(week_bdate,1);
						t_week++;
					}
					$('#div_cugtweek').html(tmp_checkbox);
				});
				
				$('#btnDate2').click(function() {
					var issaturday = (q_getPara('sys.saturday').toString()=='1'?'1':'0');
					if(q_cur==1 || q_cur==2){
						var t_where='1=0';
						for (var i = 0; i < q_bbsCount; i++) {
							var t_stationno=$.trim($('#txtProcessno_'+i).val());
							if(t_where.indexOf(" or noa='"+t_stationno+"'")==-1){
								t_where+=" or noa='"+t_stationno+"'";
							}
						}
						t_where="where=^^ "+t_where+" ^^";
						q_gt('station', t_where, 0, 0, 0, "getstation",r_accy,1);
						//工作站 日產能
						var tstation = _q_appendData("station", "", true);
						q_gt('stations', t_where, 0, 0, 0, "getstations",r_accy,1);
						var tstations = _q_appendData("stations", "", true);
						var t_bdate=$('#txtBdate').val();//開工日
						q_gt('holiday', "where=^^ noa>='"+t_bdate+"' ^^ stop=100" , 0, 0, 0, "getholiday", r_accy,1);
						var holiday = _q_appendData("holiday", "", true);
						
						if(t_bdate.length==0){
							t_bdate=q_cdn(q_date(),1);
							$('#txtBdate').val(q_cdn(q_date(),1));
						}
						
						//目前領料內容>會隨著製程變動								
						var t_mount=0,t_weight=0,t_mm=0,t_put=0
						for (var i = 0; i < q_bbtCount; i++) {
							t_mount=q_add(t_mount,dec($('#txtGmount__'+i).val()));
							t_weight=q_add(t_weight,dec($('#txtGweight__'+i).val()));
							t_put=q_add(t_put,dec($('#txtHard__'+i).val()));
							t_mm=q_add(t_mm,q_mul(dec($('#txtLengthb__'+i).val()),dec($('#txtGmount__'+i).val())));
						}
						
						var t_endate='';
						for (var i = 0; i < q_bbsCount; i++) {
							var t_procno=$.trim($('#txtProcessno_'+i).val()); //製程
							var t_mechno=$.trim($('#txtProductno2_'+i).val()); //機台
							if(t_procno.length>0){
								$('#txtDate2_'+i).val(t_bdate);
								$('#txtX01_'+i).val(round(t_mount,2));
								$('#txtX02_'+i).val(round(t_weight,2));
								$('#txtX03_'+i).val(round(t_mm,2));
								$('#txtX04_'+i).val(round(t_put,2));
							}
								
							//取得當天標準工時
							var t_sgen=8;
							for (var j = 0; j < tstation.length; j++) {
								if(tstation[j].noa==t_stationno && dec(tstation[j].gen)>0){
									t_sgen=dec(tstation[j].gen);
									break;
								}
							}
							q_gt('view_cugt', "where=^^stationno='"+t_procno+"' and datea>='"+t_bdate+"' ^^ stop=100", 0, 0, 0, "getcugt", r_accy,1);
							var t_cugt = _q_appendData("view_cugt", "", true);
							
							//計算製程所需時數
							var t_hours=0;
							for (var j = 0; j < tstations.length; j++) {
								if(tstations[j].noa==t_procno && tstations[j].mechno==t_mechno){
									var t_unit=tstations[j].dayno; //單位
									var t_gen=dec(tstations[j].gen); //產能
									if(t_unit.toUpperCase()=='把'){
										t_hours=round(t_put/t_gen,2);
									}
									if(t_unit.toUpperCase()=='MM'){
										t_hours=round(t_mm/t_gen,2);
									}
									if(t_unit.toUpperCase()=='米'){
										t_hours=round(t_mm/1000/t_gen,2);
									}
									if(t_unit.toUpperCase()=='支'){
										t_hours=round(t_mount/t_gen,2);
									}
									if(t_unit.toUpperCase()=='KG'){
										t_hours=round(t_weight/t_gen,2);
									}
									
									$('#txtHmount_'+i).val(t_hours);
									break;
								}
							}
							
							//變動支數和長度
							if(t_procno.toUpperCase()=='C'){//中切 變動 支數
								//看輸入幾個欄位
								var tcut=0;
								if(dec($('#textNeed1_'+i).val())>0){tcut++;}
								if(dec($('#textNeed2_'+i).val())>0){tcut++;}
								if(dec($('#textNeed3_'+i).val())>0){tcut++;}
								if(dec($('#textNeed4_'+i).val())>0){tcut++;}
								if(dec($('#textNeed5_'+i).val())>0){tcut++;}
								if(dec($('#textNeed6_'+i).val())>0){tcut++;}
								if(dec($('#textNeed7_'+i).val())>0){tcut++;}
								if(dec($('#textNeed8_'+i).val())>0){tcut++;}
								if(dec($('#textNeed9_'+i).val())>0){tcut++;}
								if(dec($('#textNeed10_'+i).val())>0){tcut++;}
								if(dec($('#textNeed11_'+i).val())>0){tcut++;}
								if(dec($('#textNeed12_'+i).val())>0){tcut++;}
								if(dec($('#textNeed13_'+i).val())>0){tcut++;}
								if(tcut>1){ //107/05/07 暫定 先*2
									//t_mount=q_mul(t_mount,tcut);
									t_mount=q_mul(t_mount,2);
								}
							}
							if(t_procno.toUpperCase()=='D'){//抽管 變動 長度
								//第3個欄位為長度
								if(dec($('#textNeed3_'+i).val())>0)
									t_mm=q_mul(t_mount,dec($('#textNeed3_'+i).val()));
							}
							
							//計算下個製程開工日
							//取得當天gen
							var t_wgen=t_sgen;
			                for (var k = 0; k < t_cugt.length; k++) {
			                	if(t_cugt[k].datea==t_bdate){
			                		t_wgen=dec(t_cugt[k].gen);
			                		break;
			                	}
			                }
			                while(t_hours>=0){
			                	t_hours=q_sub(t_hours,t_wgen);
			                	t_endate=t_bdate;
			                	t_bdate=q_cdn(t_bdate,1);
			                	
			                	var canwork=false;
			                	while(!canwork){
				                	var t_iswork=true;
									var t_holidaywork=false; //假日主檔是否要上班
				                	for(var k=0;k<holiday.length;k++){
										if(holiday[k].noa==t_bdate){
											if(holiday[k].iswork=="true"){
												t_holidaywork=true;
											}else{
												t_iswork=false;
											}
										}
									}
									if(!t_holidaywork && t_iswork){//非假日主檔內
										var week='';
										if(t_bdate.length==10){
											week=new Date(dec(t_bdate.substr(0,4)),dec(t_bdate.substr(5,2))-1,dec(t_bdate.substr(8,2))).getDay()
										}else{
											week=new Date(dec(t_bdate.substr(0,3))+1911,dec(t_bdate.substr(4,2))-1,dec(t_bdate.substr(7,2))).getDay();
										}
												
										if(issaturday!='1' && week==6)
											t_iswork=false;
										if(week==0)
											t_iswork=false;
									}
				                	
				                	if(!t_iswork){
				                		t_bdate=q_cdn(t_bdate,1);
				                	}else{
				                		canwork=true;
				                	}
				                }
			                	
			                	t_wgen=t_sgen;
			                	for (var k = 0; k < t_cugt.length; k++) {
				                	if(t_cugt[k].datea==t_bdate){
				                		t_wgen=dec(t_cugt[k].gen);
				                		break;
				                	}
				                }
			                }//開工日end
						}//製程bbs end
						$('#txtEdate').val(t_endate);
					}
				});
				
				$('#btnOK_div_in').click(function() { //入庫
					var t_noa=$('#textNoa').val();
					var t_noq=$('#textNoq').val();
					if(t_noa.length>0 && t_noq.length>0){
						var t_emount=dec($('#textErrmount').val());
						var t_eweight=dec($('#textErrweight').val());
						var t_fmount=dec($('#textFixmount').val());
						var t_fweight=dec($('#textFixweight').val());
						var t_imount=dec($('#textInmount').val());
						var t_iweight=dec($('#textInweight').val());
						var t_iput=dec($('#textInput').val());
						var t_userno=r_userno;
						var t_name=r_name;
						
						q_func('qtxt.query.cubsin_na', 'cub_na.txt,cubsin_na,' 
							+ encodeURI(t_noa) 
							+ ';' + encodeURI(t_noq) 
							+ ';' + encodeURI(t_emount)
							+ ';' + encodeURI(t_eweight)
							+ ';' + encodeURI(t_fmount)
							+ ';' + encodeURI(t_fweight)
							+ ';' + encodeURI(t_imount)
							+ ';' + encodeURI(t_iweight)
							+ ';' + encodeURI(t_iput)
							+ ';' + encodeURI(t_userno)
							+ ';' + encodeURI(t_name)
						);
					}else {
						alert('入庫失敗!!');
					}
				});
				$('#btnOK2_div_in').click(function() { //退件
					
				});
				$('#btnClose_div_in').click(function() {
					$('#div_in').hide();
				});
				
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'stpost_rc2_0':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',0');
                            sleep(100);
                        }
                        //執行txt
                        q_func('qtxt.query.cubs2rc2_xy_0', 'cub.txt,cubs2rc2_xy,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2')));
                        break;
					case 'stpost_rc2_1':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',1');
                            sleep(100);
                        }
                        Unlock(1);
                        break;
					case 'stpost_rc2_3':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',0');
                            sleep(100);
                        }
                        q_func('qtxt.query.cubs2rc2_xy_3', 'cub.txt,cubs2rc2_xy,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2')));
                        break;
					case 'getnotv':
                        var as = _q_appendData("view_cub", "", true);
                        if (as[0] != undefined) {
                            $('#txtNotv').val(as[0].notv);
                            if(as[0].enda=='true'){
                            	$('#chkEnda').prop('checked',true);
                            }else{
                            	$('#chkEnda').prop('checked',false);
                            }
                            abbm[q_recno]['notv'] = as[0].notv;
                            abbm[q_recno]['enda'] = as[0].enda;
                        }
                        break;
                    case 'getrc2no':
                        var as = _q_appendData("view_cubs", "", true);
                        for (var i = 0; i < as.length; i++) {
                            for (var j = 0; j < q_bbsCount; j++) {
                                if (as[i].noq == $('#txtNoq_' + j).val()) {
                                    $('#txtOrdeno_' + j).val(as[i].ordeno);
                                }
                            }
                            for (var j = 0; j < abbs.length; j++) {
                                if (abbs[j]['noa'] == as[i].noa && abbs[j]['noq'] == as[i].noq) {
                                    abbs[j]['ordeno'] = as[i].ordeno;
                                }
                            }

                        }
                        break;
					/*case 'cub_typea':
						var as = _q_appendData("view_cub", "", true);
						if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].typea;
		                    }
		                    q_cmbParse("combTypea", t_item, '');
		                }
						break;*/
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function sleep(milliseconds) {
                var start = new Date().getTime();
                for (var i = 0; i < 1e7; i++) {
                    if ((new Date().getTime() - start) > milliseconds) {
                        break;
                    }
                }
            }
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.cubs2rc2_xy_0':
                        q_func('qtxt.query.cubs2rc2_xy_1', 'cub.txt,cubs2rc2_xy,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';1;' + encodeURI(q_getPara('sys.key_rc2')));
                        break;
                    case 'qtxt.query.cubs2rc2_xy_1':
                        q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_1");
                        //回寫到bbs 與 bbm
                        q_gt('view_cub', "where=^^noa='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "getnotv");
                        q_gt('view_cubs', "where=^^noa='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "getrc2no");
                        break;
                    case 'qtxt.query.cubs2rc2_xy_3':
                        _btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
                        break;
					case 'qtxt.query.cugtchange':
                		alert("更新完成!!");
                		$('#btn_div_cugt').removeAttr('disabled');
                		$('#btn_div_cugt').val('更新');
                		$('#div_cugt').toggle();
                		break;
                	case 'qtxt.query.cubsin_na':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].noa==$('#txtNoa').val()){
                				for (var i = 0; i < q_bbsCount; i++) {
                					if($('#txtNoq_'+i).val()==as[0].noq){
                						$('#txtMount_'+i).val(as[0].mount);
                						$('#txtWeight_'+i).val(as[0].weight);
                						$('#txtWmount_'+i).val(as[0].wmount);
                						break;
                					}
                					
                				}
                			}
                		}
                		alert("入庫成功!!");
                		$('#div_in').hide();
                		break;
                }
            }

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
					
				if (!emp($('#txtNoa').val())) {
                    Lock(1, {
                        opacity : 0
                    });
                    
                    if($('#txtDatea').val()>='105/03/21')
                    	q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_0");
                    else
                    Unlock(1);
                }
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}else{
								$('#txtCustno').val(b_ret[0].custno);
								$('#txtComp').val(b_ret[0].comp);
								$('#txtOrdeno').val(b_ret[0].noa);
								$('#txtNo2').val(b_ret[0].no2);
								$('#txtProductno').val(b_ret[0].ucolor);
								$('#txtProduct').val(b_ret[0].product);
								$('#txtSpec').val(b_ret[0].spec);
								$('#txtMount').val(b_ret[0].mount);
								$('#txtIdime').val(b_ret[0].weight);
								$('#txtItype').val(b_ret[0].stype);
								$('#txtMemo').val(b_ret[0].memo);
								$('#txtMedate').val(b_ret[0].datea);
								$('#txtM1').val(b_ret[0].productno);
								$('#txtM2').val(b_ret[0].scolor);
								$('#txtM3').val(b_ret[0].radius);
								$('#txtM4').val(b_ret[0].width);
								$('#txtM5').val(b_ret[0].dime);
								$('#txtM6').val(b_ret[0].lengthb);
								$('#txtM7').val(b_ret[0].style);
								$('#txtM7').change();
								
								if(b_ret[0].noa.length>0){
									q_gt('view_orde', "where=^^ noa='" + b_ret[0].noa + "' ^^", 0, 0, 0, "getorde",r_accy,1);
									var as = _q_appendData("view_orde", "", true);
									if(as[0]!=undefined){
										var tstype=q_getPara('orde.stype').split(',');
										for(var i=0;i<tstype.length;i++){
											if(tstype[i].split('@')[0]==as[0].stype){
												$('#txtItype').val(tstype[i].split('@')[1]);
												break;
											}
										}
									}
								}
								
								
								var t_pno=$('#txtProductno').val();
					   			if(t_pno.length>0){
						   			q_gt('uca', "where=^^ noa='" + t_pno + "' ^^", 0, 0, 0, "getuca",r_accy,1);
									var as = _q_appendData("uca", "", true);
									if(as[0]!=undefined){
										for (var i = 0; i < q_bbtCount; i++) {
											$('#btnMinut__'+i).click();
										}
										q_gridAddRow(bbtHtm, 'tbbt', 'txtProductno,txtProduct,txtRadiu,txtWidth,txtDime,txtLengthb'
										, as.length, as, 'edate,engprono,groupino,groupjno,groupkno,grouplno', 'txtProductno');
										
									}
									var as = _q_appendData("ucat", "", true)
									if(as[0]!=undefined){
										while(q_bbsCount<as.length){
											$('#btnPlus').click();
										}
										for (var i = 0; i < q_bbsCount; i++) {
											$('#btnMinus_'+i).click();
										}
										q_gridAddRow(bbsHtm, 'tbbs', 'txtProcessno,txtProcess,txtNeed'
										, as.length, as, 'stationno,station,assm', 'txtProcessno');
									}
								}
							}
						}
						break;
					case 'bbs_mech':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}else{
								$('#txtProductno2_'+b_seq).val(b_ret[0].noa);
								$('#txtProduct2_'+b_seq).val(b_ret[0].mech);
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
					
				q_box('cub_xy_s.aspx', q_name + '_s', "500px", "510px", q_getMsg("popSeek"));
			}

			function btnIns() {
                _btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#chkIsproj').prop('checked',true);
				$('#chkEnda').prop('checked',false);
				$('#chkCancel').prop('checked',false);
				$('#txtEdate').val('');
				$('#textInano').val('');
				$('#txtC1').val('');
				$('#txtNotv').val('');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				
				q_gt('view_inas', "where=^^ rc2no='" + $('#txtNoa').val() + "' ^^", 0, 0, 0, "istoina",r_accy,1);
				var as = _q_appendData("view_inas", "", true);
				if(as[0]!=undefined){
					alert('製令單已入庫!!');
					$('#txtDatea').attr('disabled', 'disabled');
					$('#cmbTypea').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
					$('#txtMedate').attr('disabled', 'disabled');
					$('#txtIndate').attr('disabled', 'disabled');
					$('#txtProductno').attr('disabled', 'disabled');
					$('#txtSpec').attr('disabled', 'disabled');
					$('#txtPrice').attr('disabled', 'disabled');
					$('#txtMo').attr('disabled', 'disabled');
					$('#txtMemo').attr('disabled', 'disabled');
				}
				
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtOrdeno_'+i).val())){
						q_gt('pays', "where=^^ rc2no='" + $('#txtOrdeno_'+i).val() + "' ^^", 0, 0, 0, "istopay",r_accy,1);
						var as = _q_appendData("pays", "", true);
						if(as[0]!=undefined){
							$("[name='checkCut']").attr('disabled', 'disabled');
							$('#btnMinus_'+i).attr('disabled', 'disabled');
							$('#txtProcessno_'+i).attr('disabled', 'disabled');
							$('#txtProcess_'+i).attr('disabled', 'disabled');
							$('#btnProcessno_'+i).attr('disabled', 'disabled');
							$('#txtTggno_'+i).attr('disabled', 'disabled');
							$('#txtTgg_'+i).attr('disabled', 'disabled');
							$('#btnTggno_'+i).attr('disabled', 'disabled');
							$('#txtMount_'+i).attr('disabled', 'disabled');
							$('#txtPrice_'+i).attr('disabled', 'disabled');
							$('#txtMo_'+i).attr('disabled', 'disabled');
							$('#chkSale_'+i).attr('disabled', 'disabled');
							$('#txtW02_'+i).attr('disabled', 'disabled');
							$('#txtNeed_'+i).attr('disabled', 'disabled');
							$('#txtMemo_'+i).attr('disabled', 'disabled');
							$('#chkCut_'+i).attr('disabled', 'disabled');
							$('#txtDatea_'+i).attr('disabled', 'disabled');
						}
					}
				}
				
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_cub_na.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				var t_noa = trim($('#txtNoa').val());
				var t_ordeno = trim($('#txtOrdeno').val());
				var t_no2 = trim($('#txtNo2').val());
				
				var t_err = '';
				t_err = q_chkEmpField([['txtProductno', '製成品']]); //['txtOrdeno', '訂單編號']
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//105/05/03 判斷已轉製令單就不讓存檔
				if(t_ordeno.length>0 && t_no2.length>0){
					q_gt('view_cub', "where=^^ ordeno='" + t_ordeno + "' and no2='" + t_no2 + "' and  noa!='" + t_noa + "' ^^", 0, 0, 0, "getrepordeno",r_accy,1);
					var as = _q_appendData("view_cub", "", true);
		            if(as[0]!=undefined){
		            	alert('訂單【'+t_ordeno+'-'+t_no2+'】重覆轉製令單!!');
		            	return;
		            }
				}
								
				sum();
				
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['tggno'] && !as['processno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['productno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$("[name='checkCut']").prop('checked',false);
				
				//0808 顯示入庫單號
				var t_inano='';
				q_gt('view_inas', "where=^^ rc2no='" + $('#txtNoa').val() + "' and isnull(rc2no,'')!='' ^^", 0, 0, 0, "istoina",r_accy,1);
				var as = _q_appendData("view_inas", "", true);
				for (var i = 0; i < as.length; i++) {
					t_inano=t_inano+(t_inano.length>0?',':'')+as[i].noa;
				}
				$('#textInano').val(t_inano);
				$('#div_in').hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnUpdata').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
					$("[name='checkCut']").attr('disabled', 'disabled');
					$('#btnDate2').attr('disabled', 'disabled');
					$('#btnCugt2').removeAttr('disabled');
				}else{
					$('#btnUpdata').removeAttr('disabled');
					$('#btnOrdes').removeAttr('disabled');
					$("[name='checkCut']").removeAttr('disabled');
					$('#btnDate2').removeAttr('disabled');
					$('#btnCugt2').attr('disabled', 'disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#btnCubt_'+i).click(function() {
							t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            
                            var t_processno=$('#txtProcessno_'+b_seq).val();
                            
                            if(t_processno.length>0){
                            	q_box("cugt_na.aspx?;;;noa='" + t_processno + "' and stationno='"+t_processno+"'", 'cugt', "60%", "65%", q_getMsg("btnCugt"));
                            }
						});
						
						$('#btnProductno2_'+i).click(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProcessno_'+b_seq).val())){
								t_where = "noa in (select mechno from stations where noa='"+$('#txtProcessno_'+b_seq).val()+"')";
								q_box("mech_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'bbs_mech', "500px", "680px", "");
							}
						});
						
						$('#btnIn_'+i).click(function(e) {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProductno').val()) && !emp($('#txtProcessno_'+b_seq).val()) && !(q_cur==1 && q_cur==2)){
								$('#textCubno').val($('#txtNoa').val());
								$('#textProductno').val($('#txtProductno').val());
								$('#textProduct').val($('#txtProduct').val());
								$('#textStyle').val($('#txtM8').val());
								$('#textScolor').val($('#txtM2').val());
								$('#textRadius').val($('#txtM3').val());
								$('#textWidth').val($('#txtM4').val());
								$('#textDime').val($('#txtM5').val());
								$('#textLengthb').val($('#txtM6').val());
								$('#textMount').val($('#txtMount').val());
								$('#textWeight').val($('#txtIdime').val());
								$('#textStation').val($('#txtProcess_'+b_seq).val());
								$('#textMech').val($('#txtProduct2_'+b_seq).val());
								$('#textNeed').val(replaceAll($('#txtNeed_'+b_seq).val(),'@,#',' | '));
								$('#textErrmount').val('');
								$('#textErrweight').val('');
								$('#textFixmount').val('');
								$('#textFixweight').val('');
								$('#textInmount').val('');
								$('#textInweight').val('');
								$('#textInput').val('');
								$('#textWorker').val(r_name);
								$('#textBmount').val('');
								$('#textBweight').val('');
								$('#textBmemo').val('');
								var t_pn=dec(b_seq)-1;
								if(t_pn>=0){
									$('#textPrestation').val($('#txtProcess_'+t_pn).val());
									$('#textPremech').val($('#txtProduct2_'+t_pn).val());
									$('#textPreinmount').val($('#txtMount_'+t_pn).val());
									$('#textPreinweight').val($('#txtWeight_'+t_pn).val());
									$('#textPreinput').val($('#txtWmount_'+t_pn).val());
									$('#textPreworker').val('');
								}else{
									$('#textPrestation').val('');
									$('#textPremech').val('');
									$('#textPreinmount').val('');
									$('#textPreinweight').val('');
									$('#textPreinput').val('');
									$('#textPreworker').val('');
								}
								$('#div_in').css('top', e.pageY-100);
								$('#div_in').css('left', e.pageX-$('#div_in').width()-20);
								$('#textNoa').val($('#txtNoa').val());
								$('#textNoq').val($('#txtNoq_'+b_seq).val());
								$('#div_in').show();
							}
						});
					}
				}
				_bbsAssign();
				
				
				$('.needs').each(function(index) {
					$(this).unbind('change');
					$(this).change(function() {
						var n=$(this).attr('id').split('_')[1];
						var t_need='';
						for(var k=1;k<=13;k++){
							t_need=t_need+'@,#'+$('#textNeed'+k+'_'+n).val();
						}
						
						$('#txtNeed_'+n).val(t_need);
					});
				});
				splitbbsf();
			}
			
			function splitbbsf(){ //拆解bbs欄位
				for (var i = 0; i < q_bbsCount; i++) {
					//合併儲存
					var tstr=$('#txtNeed_'+i).val().split('@,#');
					if(tstr.length>1){
						for(var k=1;k<=13;k++){
							$('#textNeed'+k+'_'+i).val(tstr[k]);
						}
					}
				}
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				//_btnDele();
                if (emp($('#txtNoa').val()))
                    return;
                    
				q_gt('view_inas', "where=^^ rc2no='" + $('#txtNoa').val() + "' ^^", 0, 0, 0, "istoina",r_accy,1);
				var as = _q_appendData("view_inas", "", true);
				if(as[0]!=undefined){
					alert('製令單已入庫!!');
					return;
               }
               
                var t_pay=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtOrdeno_'+i).val())){
						q_gt('pays', "where=^^ rc2no='" + $('#txtOrdeno_'+i).val() + "' ^^", 0, 0, 0, "istopay",r_accy,1);
						var as = _q_appendData("pays", "", true);
						if(as[0]!=undefined){
							t_pay=true;
						}
					}
				}
				if(t_pay){
					alert('製令單已付款禁止刪除!!');
					return;
				}
				
				//檢查是否有刪除權限
				var pr_dele='false';
				q_gt('authority', "where=^^ a.noa='"+q_name+"' and a.sssno='"+r_userno+"' ^^", 0, 0, 0, "isauthority",r_accy,1);
				var as = _q_appendData("authority", "", true);
				if(as[0]!=undefined){
					pr_dele=as[0].pr_dele;
				}
				
				if(pr_dele=='true' || r_rank>='8'){
					if (!confirm(mess_dele))
						return;
					q_cur = 3;
		                
					if($('#txtDatea').val()>='105/03/21'){
		            	q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_3");
		            }else{
		            	_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
					}
				}else{
	              	alert('無刪除權限!!');
				}
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
	        var orde_no2='',orde_pno='',orde_product='',orde_custno='',orde_comp='',orde_spec='',orde_pop=true;
	        function q_popPost(s1) {
			   	switch (s1) {
			   		case 'txtProductno':
			   			var t_pno=$('#txtProductno').val();
			   			if(t_pno.length>0){
				   			q_gt('uca', "where=^^ noa='" + t_pno + "' ^^", 0, 0, 0, "getuca",r_accy,1);
							var as = _q_appendData("uca", "", true);
							if(as[0]!=undefined){
								$('#txtCustno').val(as[0].custno);
								$('#txtComp').val(as[0].cust);
								$('#txtM1').val(as[0].bdate);
								$('#txtM2').val(as[0].size);
								$('#txtM3').val(as[0].groupeno);
								$('#txtM4').val(as[0].groupfno);
								$('#txtM5').val(as[0].groupgno);
								$('#txtM6').val(as[0].grouphno);
								$('#txtM7').val(as[0].style);
								$('#txtM8').val(as[0].team);
								
								for (var i = 0; i < q_bbtCount; i++) {
									$('#btnMinut__'+i).click();
								}
								q_gridAddRow(bbtHtm, 'tbbt', 'txtProductno,txtProduct,txtRadiu,txtWidth,txtDime,txtLengthb'
								, as.length, as, 'edate,engprono,groupino,groupjno,groupkno,grouplno', 'txtProductno');
								
							}
							var as = _q_appendData("ucat", "", true)
							if(as[0]!=undefined){
								while(q_bbsCount<as.length){
									$('#btnPlus').click();
								}
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_'+i).click();
								}
								q_gridAddRow(bbsHtm, 'tbbs', 'txtProcessno,txtProcess,txtNeed'
								, as.length, as, 'stationno,station,assm', 'txtProcessno');
							}
						}
			   			break;
			   		case 'txtTggno_':
			   			var t_n=b_seq;
						q_gt('tgg', "where=^^ noa='" + $('#txtTggno_'+t_n).val() + "' ^^", 0, 0, 0, "gettggs",r_accy,1);
						var as = _q_appendData("tgg", "", true);
						if(as[0]!=undefined){
							$('#txtTggno_'+t_n).val(as[0].noa);
							$('#txtTgg_'+t_n).val(as[0].nick);
							if(as[0].conn=='1'){
								$('#chkSale_'+t_n).prop('checked',true);
							}else{
								$('#chkSale_'+t_n).prop('checked',false);
							}
						}
			   			break;
			   	}
			}
			
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 30%;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 70%;
				/*margin: -1px;
				 border: 1px black solid;*/
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: black;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}

			.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 2100px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				/*background: #cad3ff;*/
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs .tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			#dbbt {
				width: 1260px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_cugt" style="position:absolute; top:0px; left:0px; display:none; width:510px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_cugt" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">製程區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbstationno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textCugtestationno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr style="display: none;">
					<td style="background-color: #f8d463;width: 110px;text-align: center;">管理單位區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbstationgno' type='text' style='text-align:left;width:180px;'/>	~
						<input id='textCugtestationgno' type='text' style='text-align:left;width: 180px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">日期區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtbdate' type='text' style='text-align:left;width:100px;'/>	~
						<input id='textCugtedate' type='text' style='text-align:left;width: 100px;'/>	
						包含	<input id="checkSaturday" type="checkbox">	六 		<input id="checkSunday" type="checkbox">	日
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">工時</td>
					<td style="background-color: #f8d463;">
						<input id='textCugtGen' type='text' style='text-align:left;width:100px;'/>
						<input id="btn_div_cugtweek" type="button" style="float: right;margin-right: 75px;" value="挑選日期">
					</td>
				</tr>
				<tr id='cugt_close'>
					<td align="center" colspan='2'>
						<input id="btn_div_cugt" type="button" value="更新">
						<input id="btnClose_div_cugt" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_cugtweek" style="position:absolute; top:0px; left:0px; display:none; width:690px; background-color: rgb(255, 240, 237); border: 5px solid gray;">	</div>
		<!---DIV分隔線---->
		<!--暫時只顯示demo用-->
		<div id="div_in" style="position:absolute; top:300px; left:400px; display:none; width:650px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;">
			<table id="table_in" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: lightcyan;width: 105px;" align="center" >製令編號</td>
					<td style="background-color: lightcyan;width: 295px;" colspan="3"><input id="textCubno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;width: 105px;" align="center">製品編號</td>
					<td style="background-color: lightcyan;width: 295px;" colspan="3"><input id="textProductno" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: lightcyan;" align="center" >製品名稱</td>
					<td style="background-color: lightcyan;" colspan="7"><input id="textProduct" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: lightcyan;" align="center">型</td>
					<td style="background-color: lightcyan;" colspan="3"><input id="textStyle" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;" align="center">材質</td>
					<td style="background-color: lightcyan;" colspan="3"><input id="textScolor" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: lightcyan;" align="center" >短徑</td>
					<td style="background-color: lightcyan;"><input id="textRadius" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;width:55px;" align="center" >長徑</td>
					<td style="background-color: lightcyan;"><input id="textWidth" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;" align="center" >厚度</td>
					<td style="background-color: lightcyan;"><input id="textDime" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;width:55px;" align="center" >長度</td>
					<td style="background-color: lightcyan;"><input id="textLengthb" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: lightcyan;" align="center">預計/支</td>
					<td style="background-color: lightcyan;" colspan="3"><input id="textMount" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: lightcyan;" align="center">產量/KG</td>
					<td style="background-color: lightcyan;" colspan="3"><input id="textWeight" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td colspan="8" style="height: 1px;background-color:grey;" > </td>
				</tr>
				<tr>
					<td style="background-color: oldlace;" align="center">目前製程</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textStation" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: oldlace;" align="center">使用機台</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textMech" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: oldlace;" align="center">製程備註</td>
					<td style="background-color: oldlace;" colspan="7"><input id="textNeed" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: oldlace;" align="center">本次報廢支數</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textErrmount" style="font-size: medium;width:98%;text-align: right;"></td>
					<td style="background-color: oldlace;" align="center">本次報廢重量</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textErrweight" style="font-size: medium;width:98%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: oldlace;" align="center">本次維修支數</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textFixmount" style="font-size: medium;width:98%;text-align: right;"></td>
					<td style="background-color: oldlace;" align="center">本次維修重量</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textFixweight" style="font-size: medium;width:98%;text-align: right;"></td>
				</tr>				
				<tr>
					<td style="background-color: oldlace;" align="center">本次入庫數量</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textInmount" style="font-size: medium;width:98%;text-align: right;"></td>
					<td style="background-color: oldlace;" align="center">本次入庫重量</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textInweight" style="font-size: medium;width:98%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: oldlace;" align="center">本次入庫把數</td>
					<td style="background-color: oldlace;" colspan="3"><input id="textInput" style="font-size: medium;width:98%;text-align: right;"></td>
					<td style="background-color: oldlace;" align="center">入庫人員</td>
					<td style="background-color: oldlace;" colspan="3">
						<input id="textWorker" style="font-size: medium;width:70%;" disabled="disabled">
						<input id="btnOK_div_in" type="button" value="入庫" style="font-size: medium;font-weight: bold;color: blue;">
					</td>
				</tr>
				<tr>
					<td style="background-color: #ffddff;" align="center">本次退件支數</td>
					<td style="background-color: #ffddff;" colspan="3"><input id="textBmount" style="font-size: medium;width:98%;text-align: right;"></td>
					<td style="background-color: #ffddff;" align="center">本次退件重量</td>
					<td style="background-color: #ffddff;" colspan="3"><input id="textBweight" style="font-size: medium;width:98%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: #ffddff;" align="center">退件原因</td>
					<td style="background-color: #ffddff;" colspan="7">
						<input id="textBmemo" style="font-size: medium;width:88%;">
						<input id="btnOK2_div_in" type="button" value="退件" style="font-size: medium;font-weight: bold;color: red;">
					</td>
				</tr>
				<tr>
					<td colspan="8" style="height: 1px;background-color:grey;" > </td>
				</tr>
				<tr>
					<td style="background-color: #ffffaa;" align="center">上工段製程</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPrestation" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center">上工段機台</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPremech" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #ffffaa;" align="center">已入庫數量</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPreinmount" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center">已入庫重量</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPreinweight" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #ffffaa;" align="center">已入庫把數</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPreinput" style="font-size: medium;width:98%;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center">上工段人員</td>
					<td style="background-color: #ffffaa;" colspan="3"><input id="textPreworker" style="font-size: medium;width:98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td colspan="8" style="height: 1px;background-color:grey;" > </td>
				</tr>
				<tr id="table_in_bottom">
					<td colspan="8" style="text-align: center;">
						<input id="btnClose_div_in" type="button" value="關閉視窗" style="font-size: medium;">
						<input id="textNoa" type="hidden">
						<input id="textNoq" type="hidden">
					</td>
				</tr>
			</table>
		</div>
		<!---DIV分隔線---->
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td style="color:black;"><a id='vewComp'>客戶簡稱</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='comp' style="text-align: center;">~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td style="width: 95px;"> </td>
						<td style="width: 210px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 210px;"> </td>
						<td style="width: 95px;"> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl">製令單別</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn" >客戶簡稱</a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><input id="btnOrdes" type="button" value='訂單匯入'  style="float:right;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl" >訂單編號</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNo2" class="lbl" >訂序</a></td>
						<td><input id="txtNo2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMedate_na" class="lbl" >訂單預交日</a></td>
						<td><input id="txtMedate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn" >製成品</a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblItype_na" class="lbl" >訂單類別</a></td>
						<td><input id="txtItype" type="text" class="txt c1" style="width:35%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblMenda_na" class="lbl" style="float: left;">定尺</a>
							<span style="float: left;"> </span>
							<input id="chkMenda" type="checkbox"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM7_na" class="lbl">型</a></td>
						<td>
							<input id="txtM7" type="text" class="txt c1" style="width:40%;"/>
							<input id="txtM8" type="text" class="txt c1" style="width:55%;"/>
						</td>
						<td><span> </span><a id="lblM1_na" class="lbl">成品材質</a></td>
						<td>
							<input id="txtM1" type="text" class="txt c1" style="width:40%;"/>
							<input id="txtM2" type="text" class="txt c1" style="width:55%;"/>
						</td>
						<td><span> </span><a id="lblSpec_na" class="lbl" >規格</a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM3_na" class="lbl" >短徑</a></td>
						<td><input id="txtM3" type="text" class="txt c1 num" style="width:35%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblM4_na" class="lbl" style="float: left;">長徑</a>
							<span style="float: left;"> </span>
							<input id="txtM4" type="text" class="txt c1 num" style="width:35%;"/>
						</td>
						<td><span> </span><a id="lblM5_na" class="lbl" >厚度</a></td>
						<td><input id="txtM5" type="text" class="txt c1 num" style="width:35%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblM6_na" class="lbl" style="float: left;">長度</a>
							<span style="float: left;"> </span>
							<input id="txtM6" type="text" class="txt c1 num" style="width:35%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount_na" class="lbl" >預計/支</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblIdime_na" class="lbl" >產量/KG</a></td>
						<td><input id="txtIdime" type="text" class="txt num c1"/></td>
						<td><input type="button" id="btnCubu_na" value="入庫"></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblC1" class="lbl" >已交量</a></td>
						<td><input id="txtC1" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblNotv" class="lbl" >未交量</a></td>
						<td><input id="txtNotv" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblInano" class="lbl" >入庫單號</a></td>
						<td><input id="textInano" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblPrice_na" class="lbl" >單價</a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblMoney" class="lbl" >總計</a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBdate_na" class="lbl" >預定開工日</a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEdate_na" class="lbl" >預估完工日</a></td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
						<td colspan="2">
							<input id="btnDate2" type="button" value="製程開工日試算" style="float:center;"/>
							<input id="btnCugt2" type="button" value="產能批次調整" style="float:center;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2_na" class="lbl">特殊要求</a></td>
						<td><input id="txtMemo2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'>專案</a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'>結案</a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'>取消</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:150px;"><a id='lblProcess_na_s'>製程</a></td>
					<td style="width:40px;"><a id='lblCugt_na_s'>產能編制</a></td>
					<td style="width:60px;"><a id='lblNeed1_na_s'>製程備註<BR>1</a></td>
					<td style="width:60px;"><a id='lblNeed2_na_s'>製程備註<BR>2</a></td>
					<td style="width:60px;"><a id='lblNeed3_na_s'>製程備註<BR>3</a></td>
					<td style="width:60px;"><a id='lblNeed4_na_s'>製程備註<BR>4</a></td>
					<td style="width:60px;"><a id='lblNeed5_na_s'>製程備註<BR>5</a></td>
					<td style="width:60px;"><a id='lblNeed6_na_s'>製程備註<BR>6</a></td>
					<td style="width:60px;"><a id='lblNeed7_na_s'>製程備註<BR>7</a></td>
					<td style="width:60px;"><a id='lblNeed8_na_s'>製程備註<BR>8</a></td>
					<td style="width:60px;"><a id='lblNeed9_na_s'>製程備註<BR>9</a></td>
					<td style="width:60px;"><a id='lblNeed10_na_s'>製程備註<BR>10</a></td>
					<td style="width:60px;"><a id='lblNeed11_na_s'>製程備註<BR>11</a></td>
					<td style="width:60px;"><a id='lblNeed12_na_s'>製程備註<BR>12</a></td>
					<td style="width:60px;"><a id='lblNeed13_na_s'>製程備註<BR>13</a></td>
					<td style="width:150px;"><a id='lblProductno2_na_s'>機台</a></td>
					<td style="width:60px;"><a id='lblX01_na_s'>預計入庫支數</a></td>
					<td style="width:60px;display: none;"><a id='lblX02_na_s'>預計入庫重量</a></td>
					<td style="width:60px;"><a id='lblX03_na_s'>預計入庫MM</a></td>
					<td style="width:60px;display: none;"><a id='lblX04_na_s'>預計入庫把數</a></td>
					<td style="width:50px;"><a id='lblHmount_na_s'>工時</a></td>
					<td style="width:90px;"><a id='lblDate2_na_s'>指定開工日</a></td>
					<td style="width:50px;"><a id='lblMount_na_s'>完工<BR>支數</a></td>
					<td style="width:50px;"><a id='lblWeight_na_s'>完工<BR>重量</a></td>
					<td style="width:50px;"><a id='lblWmount_na_s'>完工<BR>把數</a></td>
					<td style="width:50px;"><a id='lblEnda_na_s'>完工</a></td>
					<td style="width:50px;"><a id='lblIn_na_s'>入庫</a></td>
					<!--
					<td style="width:140px;"><a id='lblTgg_na_s'>廠商簡稱</a></td>
					<td style="width:80px;"><a id='lblMount_na_s'>請款數量</a></td>
					<td style="width:70px;"><a id='lblPrice_na_s'>單價</a></td>
					<td style="width:100px;"><a id='lblMoney_na_s'>金額</a></td>
					<td style="width:40px;"><a id='lblSale_na_s'>外加稅</a></td>
					<td style="width:100px;"><a id='lblTxa_na_s'>稅金</a></td>
					<td style="width:100px;"><a id='lblW01_na_s'>總金額</a></td>
					<td style="width:130px;"><a id='lblMemo_na_s'>備註</a></td>
					<td style="width:40px;">
						<a id='lblPay_na_s'>請款</a>
						<input name="checkCut" type="checkbox" class="txt c1"/>
					</td>
					<td style="width:100px;"><a id='lblDatea_na_s'>帳款日期</a></td>
					<td style="width:140px;"><a id='lblOrdeno_na_s'>進貨單號</a></td>-->
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						<input id="txtNeed.*" type="hidden" class="txt c1"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcessno.*" type="text" class="txt c1" style="width: 25%;"/>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProcess.*" type="text" class="txt c1"  style="width: 55%;"/>
					</td>
					<td><input class="btn" id="btnCubt.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td><input id="textNeed1.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed2.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed3.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed4.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed5.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed6.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed7.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed8.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed9.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed10.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed11.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed12.*" type="text" class="txt c1 needs"/></td>
					<td><input id="textNeed13.*" type="text" class="txt c1 needs"/></td>
					<td>
						<input id="txtProductno2.*" type="text" class="txt c1" style="width: 25%;"/>
						<input class="btn" id="btnProductno2.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProduct2.*" type="text" class="txt c1" style="width: 55%;"/>
					</td>
					<td><input id="txtX01.*" type="text" class="txt num c1"/></td>
					<td style="display: none;"><input id="txtX02.*" type="text" class="txt num c1"/></td>
					<td><input id="txtX03.*" type="text" class="txt num c1"/></td>
					<td style="display: none;"><input id="txtX04.*" type="text" class="txt num c1"/></td>
					<td><input id="txtHmount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWmount.*" type="text" class="txt num c1"/></td>
					<td><input id="chkEnda.*" type="checkbox" class="txt c1"/></td>
					<td><input class="btn" id="btnIn.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<!--
					<td>
						<input id="txtTggno.*" type="text" class="txt c1" style="width: 80%;"/>
						<input class="btn" id="btnTggno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtTgg.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMo.*" type="text" class="txt c1 num"/></td>
					<td><input id="chkSale.*" type="checkbox" class="txt c1" /></td>
					<td><input id="txtW02.*" type="text" class="txt c1" style="text-align:right;"/></td>
					<td><input id="txtW01.*" type="text" class="txt c1" style="text-align:right; "/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td><input id="chkCut.*" type="checkbox" class="txt c1"/></td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1 num" style="color:blue;width: 90%;text-align:left;"/></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:140px; text-align: center;"><a id="lblUno_na">批號</a></td>
					<td style="width:60px; text-align: center;"><a id="lblStyle_na">型</a></td>
					<td style="width:150px; text-align: center;"><a id="lblProductno_na">素材材質</a></td>
					<td style="width:60px; text-align: center;"><a id="lblRadius_na">短徑</a></td>
					<td style="width:60px; text-align: center;"><a id="lblWidth_na">長徑</a></td>
					<td style="width:60px; text-align: center;"><a id="lblDime_na">厚度</a></td>
					<td style="width:60px; text-align: center;"><a id="lblLengthb_na">長度</a></td>
					<td style="width:80px; text-align: center;"><a id="lblGmount_na">下料/支</a></td>
					<td style="width:80px; text-align: center;"><a id="lblGweight_na">重量/KG</a></td>
					<td style="width:80px; text-align: center;"><a id="lblHard_na">下料/把</a></td>
					<td style="width:120px; text-align: center;">領料倉</td>
					<td style="width:140px; text-align: center;">備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtStyle..*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnStyle..*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProductno..*" type="text" class="txt c1" style="width: 30%;"/>
						<input class="btn" id="btnProductno..*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProduct..*" type="text" class="txt c1" style="width: 50%;"/>
					</td>
					<td><input id="txtRadius..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtDime..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGweight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtHard..*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtStoreno..*" type="text" class="txt c1" style="width: 30%"/>
						<input class="btn" id="btnStoreno..*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore..*" type="text" class="txt c1" style="width: 45%"/>
					</td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>