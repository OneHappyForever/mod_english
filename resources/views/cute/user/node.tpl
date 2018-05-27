


{include file='user/main.tpl'}


<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
<script src="//cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>

	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">Server List</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<p>
									<a class="btn btn-flat waves-attach waves-effect" href="/user/shop"><i class="icon icon-lg">check</i>&nbsp;Please purchase a subscription first！</a>
									【！】Please do not share these servers publicly, including on social media!	
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<h4>App download：</h4>
									
									<div class="col-lg-2 col-sm-3">
										<div class="dl_con">

										<p><i class="icon icon-lg">desktop_windows</i> Windows&nbsp;</p>
										<p><a href="/ssr-download/ssr-win.7z" target="_blank">Download</a></p>
										<p><a href="http://www.jianshu.com/p/751bdd68ccab" target="_blank">Setup instructions</a></p>

										</div>
									</div>

									<div class="col-lg-2 col-sm-3">
										<div class="dl_con">

										 <p><i class="icon icon-lg">laptop_mac</i> Mac OS&nbsp;</p>
										 <p><a href="/ssr-download/ssr-mac.dmg" target="_blank">Download</a></p>
										 <p><a href="http://www.jianshu.com/p/ba2eb3acb085" target="_blank">Setup instructions</a></p>

										</div>
									</div>

									<div class="col-lg-2 col-sm-3">
										<div class="dl_con">

										 <p><i class="icon icon-lg">android</i> Android&nbsp;</p>
										 <p><a href="/ssr-download/ssr-android.apk" target="_blank">Download</a></p>
										 <p><a href="http://www.jianshu.com/p/2c5eb5a5c2c3" target="_blank">Setup instructions</a></p>

										</div>
									</div>

									<div class="col-lg-2 col-sm-3">
										<div class="dl_con">

										 <p><i class="icon icon-lg">phone_iphone</i> iOS&nbsp;</p>
										 <p><a href="https://u.nu/z-2" target="_blank">Download</a> <span style="color: #f00">Please use a foreign iTunes ID</span></p>
										 <p><a href="http://www.jianshu.com/p/c6e9788f5f00" target="_blank">Setup instructions</a></p>

										</div>
									</div>

									

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">

							<div class="card">
								<div class="card-main node">
									<div class="card-inner margin-bottom-no">

										{if $user->unusedTraffic() != null}
										<div class="tile-wrap">
											<div class="col-lg-12 col-sm-12">
											<div class="use-con">
												<div class="sub">
													Account grade <span class="label label-brand-accent">VIP{$user->class}</span> 
													
													<span class="label btn-flat btn-orange">Data left: {$user->unusedTraffic()}</span>   
													<span class="label btn-flat btn-red">Data used today: {$user->TodayusedTraffic()} | Total used: {$user->LastusedTraffic()}</span> 
													
													<div class="pull-right">
													Last time online：{$user->lastSsTime()}
													</div>
												</div>
											</div>
											</div>
										</div>
										{/if}


										<div class="tile-wrap">
											{$id=0}
											{foreach $node_prefix as $prefix => $nodes}
												{$id=$id+1}


																{foreach $nodes as $node}

																	{$relay_rule = null}
																	{if $node->sort == 10}
																		{$relay_rule = $tools->pick_out_relay_rule($node->id, $user->port, $relay_rules)}
																	{/if}

																	{if $node->mu_only != 1}
																	<div class="col-lg-4 col-sm-6">
																	<div class="card">
																		<div class="card-main">
																			<div class="card-inner">
																			<p class="card-heading" >
																				Server name: {$node->name}{if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if}
																			</p>

																			<a class="btn btn-flat pull-right" href="javascript:void(0);" onClick="urlChange('{$node->id}',0,{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">Server QR code</a>

																			<p>
																				Server status：
																				{if $node_heartbeat[$prefix]=="在线"}
																				<span class="label label-brand-accent">Online</span>
																				{else}{if $node_heartbeat[$prefix]=='暂无数据'}
																				<span class="label">report</span>
																				{else}
																				<span class="label">Offline</span>
																				{/if}{/if}
																			</p>

																			{if $node->sort == 0||$node->sort==7||$node->sort==8||$node->sort==10}
																																							

																				<p>Data usage ratio：
																				<span class="label label-red">
																					{$node->traffic_rate}
																				</span></p>
																				
																			{/if}

																				<p>Details：
																				{$node->info}</p>

																				{if $user->isAdmin()}

																				<p>Users on this server：
																					{$node_alive[$prefix]}
																				</p>

																				<p>Total data used：
																					{if isset($node_bandwidth[$prefix])==true}{$node_bandwidth[$prefix]}{else}N/A{/if}
																				</p>

																				{/if}																	

																			 </div>

																		</div>
																	</div>
																	</div>
																	{/if}

																{/foreach}

											{/foreach}
										</div>
									</div>

								</div>
							</div>
						</div>

						<div aria-hidden="true" class="modal modal-va-middle fade" id="nodeinfo" role="dialog" tabindex="-1">
							<div class="modal-dialog modal-full">
								<div class="modal-content">
									<iframe class="iframe-seamless" title="Modal with iFrame" id="infoifram"></iframe>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}


<script>
function urlChange(id,is_mu,rule_id) {
    var site = './node/'+id+'?ismu='+is_mu+'&relay_rule='+rule_id;
	if(id == 'guide')
	{
		var doc = document.getElementById('infoifram').contentWindow.document;
		doc.open();
		doc.write('<img src="https://i.loli.net/2017/08/22/599b07e61d823.gif" style="width:500px;height:500px; border: none;"/>');
		doc.close();
	}
	else
	{
		document.getElementById('infoifram').src = site;
	}
	$("#nodeinfo").modal();
}
</script>
