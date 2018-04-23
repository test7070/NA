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
			var q_readonly = ['txtNoa','txtComp','txtProduct','txtWorker','txtWorker2','txtNotv','txtC1','txtOrdeno','txtNo2','textInano','txtEdate','txtSpec','txtBdate','textScolor','txtUnit'];
			var q_readonlys = ['txtOrdeno', 'txtNo2','txtMo','txtW01'];
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
				['txtProductno', 'lblProduct', 'ucc', 'noa,product,style,spec,unit', 'txtProductno,txtProduct,,txtSpec,txtUnit', 'ucaucc_b.aspx'],
				['txtTggno_', '', 'tgg', 'noa,nick', 'txtTggno_,txtTgg_', ""],
				['txtProcessno_', 'btnProcessno_', 'process', 'noa,process,tggno,tgg', 'txtProcessno_,txtProcess_,txtTggno_,txtTgg_', 'process_b.aspx'],
				['txtProductno__', 'btnProductno__', 'ucc', 'noa,product,spec,unit', 'txtProductno__,txtProduct__,txtSpec__,txtUnit__', 'ucaucc_b.aspx'],
				['txtStoreno__', 'btnStoreno__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx']
				,['textCugtbstationno', '', 'process', 'noa,process', 'textCugtbstationno', ''],['textCugtestationno', '', 'process', 'noa,process', 'textCugtestationno', '']
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
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				
				bbmNum = [['txtMount',10,q_getPara('vcc.mountPrecision'),1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtNotv',10,q_getPara('vcc.mountPrecision'),1]];
				bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtW02', 15, 0, 1],['txtW01', 15, 0, 1],['txtW03', 4, 0, 1]];
				bbtNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1]];
				q_mask(bbmMask);
				
				//q_cmbParse("combTypea", '西餐紙,火柴,筷子套,刀叉套,比薩盒,蛋糕盒,店卡,名片,餐盒,聯單,背心袋,炸雞盤,薯條杯,雜類,炸雞盒,紙袋,手提紙袋,瓦楞紙,帽子,桌巾紙,紙盒,公文袋,牙千套,紙包吸,紙包可吸,紙包可彩吸,紙包彩吸,紙包白色吸,白色吸,其他');
				//q_cmbParse("cmbTypea", '製造部,加工部,委外部,採購部');
				
				//$('title').text("連續製令單"); //IE8會有問題
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
						q_box("ordes_b_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
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
						q_box("ina_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ina_xy', "95%", "650px", '入庫單');
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
								$('#txtProductno').val(b_ret[0].productno);
								$('#txtProduct').val(b_ret[0].product);
								$('#txtUnit').val(b_ret[0].unit);
								$('#txtMount').val(b_ret[0].mount);
								$('#txtMemo').val(b_ret[0].memo);
								$('#txtBdate').val(b_ret[0].datea);
							}
						}
						break;
					case 'bbs_tgg':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}else{
								$('#txtTggno_'+b_seq).val(b_ret[0].noa);
								$('#txtTgg_'+b_seq).val(b_ret[0].nick);
								if(b_ret[0].conn=='1'){
									$('#chkSale_'+b_seq).prop('checked',true);
								}else{
									$('#chkSale_'+b_seq).prop('checked',false);
								}
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
					$('#txtBdate').attr('disabled', 'disabled');
					$('#txtIndate').attr('disabled', 'disabled');
					$('#txtProductno').attr('disabled', 'disabled');
					$('#txtSpec').attr('disabled', 'disabled');
					$('#txtPrice').attr('disabled', 'disabled');
					$('#txtUnit').attr('disabled', 'disabled');
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
							$('#txtUnit_'+i).attr('disabled', 'disabled');
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
				
				//105/10/03 當最後一筆有KEY 工作天數才計算預估完工日
				if(!emp($('#txtDatea').val())){
					var t_w03=0,isw03=0;
					for (var j = 0; j < q_bbsCount; j++) {
						t_w03=q_add(t_w03,$('#txtW03_'+j).val());
						if(!emp($('#txtProcessno_'+j).val())){
							isw03=dec($('#txtW03_'+j).val());
						}
					}
					if(isw03!=0){
						var t_year=dec($('#txtDatea').val().substr(0,r_len));
						var t_mon=dec($('#txtDatea').val().substr(r_len+1,2))-1;
						var t_day=dec($('#txtDatea').val().substr(r_lenm+1,2));
						if(r_len==3)
							t_year=t_year+1911;
						var t_datea=new Date(t_year,t_mon,t_day);
							
						while(t_w03>0){
							t_datea.setDate(t_datea.getDate()+1);
							if(t_datea.getDay()!=0 && t_datea.getDay()!=6){
								t_w03--;
							}
						}
						t_year=t_datea.getFullYear();
						t_mon=t_datea.getMonth();
						t_day=t_datea.getDate();
								
						if(r_len==3)
							t_year=t_year-1911;
						t_year=('0000'+(t_year).toString()).slice(-1*r_len);
						t_mon=('00'+(t_mon+1).toString()).slice(-2);
						t_day=('00'+(t_day).toString()).slice(-2);
								
						$('#txtEdate').val(t_year+'/'+t_mon+'/'+t_day);
					}else{
						$('#txtEdate').val('');
					}
				}
				
				sum();
				
				for (var i = 0; i < q_bbtCount; i++) {
					$('#txtGmount__'+i).val($('#txtMount__'+i).val());
				}
				
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
				
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnUpdata').attr('disabled', 'disabled');
					$('#btnOrdes').attr('disabled', 'disabled');
					$("[name='checkCut']").attr('disabled', 'disabled');
					$('#btnCugt2').removeAttr('disabled');
				}else{
					$('#btnUpdata').removeAttr('disabled');
					$('#btnOrdes').removeAttr('disabled');
					$("[name='checkCut']").removeAttr('disabled');
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
						
						$('#txtOrdeno_' + i).click(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            var t_rc2no = $.trim($("#txtOrdeno_" + b_seq).val());
                            if (t_rc2no.length > 0) {
                                var t_where = "noa='" + t_rc2no + "'";
                                q_box("rc2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, q_name, "98%", "98%", q_getMsg("popSeek"));
                            }
                        });
						
						$('#btnTggno_'+i).click(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "noa in (select tggno from processs where noa='"+$('#txtProcessno_'+b_seq).val()+"') or noa='"+$('#txtTggno_'+b_seq).val()+"'";
							q_box("tgg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'bbs_tgg', "500px", "680px", "");
						});
						
						$('#txtTggno_'+i).change(function() {
							var t_n=$(this).attr('id').split('_')[1];
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
						});
						
						$('#chkCut_'+i).click(function() {
							t_IdSeq = -1; 
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($(this).prop('checked') && emp($('#txtDatea_'+b_seq).val())){
								$('#txtDatea_'+b_seq).val(q_date());
							}
						});
						
						$('#txtMount_' + i).change(function() {    
                        	t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;  	
                            if(dec($('#txtMount_' + b_seq).val())>0 && dec($('#txtPrice_' + b_seq).val())>0){
                            	t_mount = dec($('#txtMount_' + b_seq).val());
                            	t_price = dec($('#txtPrice_' + b_seq).val());
                            	$('#txtMo_' + b_seq).val(round(q_mul(t_mount,t_price),0));
                            	if ($('#chkSale_' + b_seq).is(':checked')) {
	                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
	                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
	                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
	                            }
                            	$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                            }                    			                	
                        });
						
						$('#txtPrice_' + i).change(function() {
                        	t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;  	
                            if(dec($('#txtMount_' + b_seq).val())>0 && dec($('#txtPrice_' + b_seq).val())>0){
                            	t_mount = dec($('#txtMount_' + b_seq).val());
                            	t_price = dec($('#txtPrice_' + b_seq).val());
                            	$('#txtMo_' + b_seq).val(round(q_mul(t_mount,t_price),0));
                            	if ($('#chkSale_' + b_seq).is(':checked')) {
	                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
	                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
	                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
	                            }
                            	$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                            }   
                        });
						
						if ($('#chkSale_' + i).is(':checked'))
                            $('#txtW02_' + i).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
						
						$('#chkSale_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#chkSale_' + b_seq).is(':checked')) {
                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
                            } else
                                $('#txtW02_' + b_seq).css('color', 'black').css('background', 'white').removeAttr('readonly');
							
							$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                        })
                        
                        $('#txtW02_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
							
							$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                        });
                        
                        $('#txtW03_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
							
                        });
					}
				}
				_bbsAssign();
				if(q_cur==1 || q_cur==2){
					$("[name='checkCut']").removeAttr('disabled');
				}else{
					$("[name='checkCut']").attr('disabled', 'disabled');
				}
				$("[name='checkCut']").unbind('click');
				$("[name='checkCut']").click(function() {
					if((q_cur==1 || q_cur==2)){
						for (var j = 0; j < q_bbsCount; j++) {
							if($("[name='checkCut']").prop('checked')){
								$('#chkCut_'+j).prop('checked',true);
								$('#chkCut_'+j).click();
								$('#chkCut_'+j).prop('checked',true);	
							}else{
								$('#chkCut_'+j).prop('checked',false);
							}
						}
					}
				});
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
			.tbbm tr td {
				width: 9%;
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
				width: 1380px;
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
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a class="lbl">類別</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>-->
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
						<td><span> </span><a id="lblBdate" class="lbl" >訂單預交日</a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn" >製成品</a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEdate" class="lbl" >預估完工日</a></td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl" >規格</a></td>
						<td colspan="3"><input id="txtSpec" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl" >數量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblUnit" class="lbl" >單位</a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPrice" class="lbl" >單價</a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl" >總計</a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblInano" class="lbl" >入庫單號</a></td>
						<td><input id="textInano" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblC1" class="lbl" >已交量</a></td>
						<td><input id="txtC1" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblNotv" class="lbl" >未交量</a></td>
						<td><input id="txtNotv" type="text" class="txt num c1"/></td>
						<td><input id="btnCugt2" type="button" value="產能批次調整" style="float:right;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
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
					<td style="width:120px;"><a id='lblProcess_na_s'>製程名稱</a></td>
					<td style="width:40px;"><a id='lblCugt_na_s'>產能編制</a></td>
					<td style="width:100px;"><a id='lblDate2_na_s'>開工日</a></td>
					<td style="width:140px;"><a id='lblTgg_na_s'>廠商簡稱</a></td>
					<td style="width:80px;"><a id='lblMount_na_s'>數量</a></td>
					<td style="width:40px;"><a id='lblUnit_na_s'>單位</a></td>
					<td style="width:70px;"><a id='lblPrice_na_s'>單價</a></td>
					<td style="width:100px;"><a id='lblMoney_na_s'>金額</a></td>
					<td style="width:40px;"><a id='lblSale_na_s'>外加稅</a></td>
					<td style="width:100px;"><a id='lblTxa_na_s'>稅金</a></td>
					<td style="width:100px;"><a id='lblW01_na_s'>總金額</a></td>
					<td style="width:130px;"><a id='lblNeed_na_s'>製造要求</a><BR><a id='lblMemo_na_s'>備註</a></td>
					<td style="width:40px;">
						<a id='lblPay_na_s'>請款</a>
						<input name="checkCut" type="checkbox" class="txt c1"/>
					</td>
					<td style="width:100px;"><a id='lblDatea_na_s'>帳款日期</a></td>
					<td style="width:140px;"><a id='lblOrdeno_na_s'>進貨單號</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcessno.*" type="text" class="txt c1" style="width: 75%;"/>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProcess.*" type="text" class="txt c1"/>
					</td>
					<td><input class="btn" id="btnCubt.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtTggno.*" type="text" class="txt c1" style="width: 80%;"/>
						<input class="btn" id="btnTggno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtTgg.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMo.*" type="text" class="txt c1 num"/></td>
					<td><input id="chkSale.*" type="checkbox" class="txt c1" /></td>
					<td><input id="txtW02.*" type="text" class="txt c1" style="text-align:right;"/></td>
					<td><input id="txtW01.*" type="text" class="txt c1" style="text-align:right; "/></td>
					<td>
						<input id="txtNeed.*" type="text" class="txt c1"/>
						<input id="txtMemo.*" type="text" class="txt c1"/>
					</td>
					<td><input id="chkCut.*" type="checkbox" class="txt c1"/></td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1 num" style="color:blue;width: 90%;text-align:left;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:150px; text-align: center;">領料編號</td>
					<td style="width:200px; text-align: center;">領料名稱</td>
					<td style="width:200px; text-align: center;">規格</td>
					<td style="width:40px; text-align: center;">單位</td>
					<td style="width:100px; text-align: center;">領料數量</td>
					<td style="width:120px; text-align: center;">領料倉</td>
					<td style="width:200px; text-align: center;">備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno..*" type="text" class="txt c1" style="width: 85%;"/>
						<input class="btn" id="btnProductno..*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit..*" type="text" class="txt c1"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/>
						<input id="txtGmount..*" type="hidden" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtStoreno..*" type="text" class="txt c1" style="width: 30%"/>
						<input class="btn" id="btnStoreno..*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore..*" type="text" class="txt c1" style="width: 50%"/>
					</td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>