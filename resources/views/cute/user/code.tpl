








{include file='user/main.tpl'}







<main class="content">
	<div class="content-header ui-content-header">
		<div class="container">
			<h1 class="content-heading">Credits Purchase</h1>
			<p>Please choose your prefered method of payment:</p>
			<h4 class="content-heading">Current balance: {$user->money} rmb</h4>
		</div>
	</div>
	<div class="container">
		<section class="content-inner margin-top-no">
			<div class="row">
				<div class="col-lg-12 col-md-12">
					<div class="card margin-bottom-no">
						<div class="card-main">
							<div class="card-inner">
								<div class="card-inner">
									<p class="card-heading">Gift card code:</p>
									<p>Current balance：{$user->money} rmb/p>
									<div class="form-group form-group-label">
										<label class="floating-label" for="code">Gift card code</label>
										<input class="form-control" id="code" type="text">
									</div>
								</div>
								<div class="card-action">
									<div class="card-action-btn pull-left">
										<button class="btn btn-flat waves-attach" id="code-update" ><span class="icon">check</span>&nbsp;Recharge</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-4 col-md-8">
					<div class="card margin-bottom-no">
						<div class="card-main">
							<div class="card-inner">
								<div class="card-inner" style="height:150px">
									<h4 class="showmoney">
										Current balance：
										<p>{$user->money} rmb</p>
									</h4>
								</div>

							</div>
						</div>
					</div>
				</div>

                {if $pmw!=''}
					<div class="col-lg-8 col-md-4">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<div class="card-inner">
                                        {$pmw}
									</div>

								</div>
							</div>
						</div>
					</div>
                {/if}

				<div class="col-lg-12 col-md-12">
					<div class="card margin-bottom-no">
						<div class="card-main">
							<div class="card-inner">
								<div class="card-inner">
									<div class="card-table">
										<div class="table-responsive">
                                            {$codes->render()}
											<table class="table table-hover">
												<tr>
													<th>ID</th>
													<th>Transaction number</th>
													<th>Type</th>
													<th>Action</th>
													<th>Time</th>

												</tr>
                                                {foreach $codes as $code}
                                                    {if $code->type!=-2}
														<tr>
															<td>#{$code->id}</td>
															<td>{$code->code}</td>
                                                            {if $code->type==-1}
																<td>Credits purchase</td>
                                                            {/if}
                                                            {if $code->type==10001}
																<td>Data package purchase</td>
                                                            {/if}
                                                            {if $code->type==10002}
																<td>Subscription renewal</td>
                                                            {/if}
                                                            {if $code->type>=1&&$code->type<=10000}
																<td>Grade expired - grade {$code->type}</td>
                                                            {/if}
                                                            {if $code->type==-1}
																<td>Purchased {$code->number} rmb</td>
                                                            {/if}
                                                            {if $code->type==10001}
																<td>Purchased {$code->number} GB data transfer package</td>
                                                            {/if}
                                                            {if $code->type==10002}
																<td>Subscription lengthened by {$code->number} days</td>
                                                            {/if}
                                                            {if $code->type>=1&&$code->type<=10000}
																<td>Grade lengthened by {$code->number} days</td>
                                                            {/if}
															<td>{$code->usedatetime}</td>
														</tr>
                                                    {/if}
                                                {/foreach}
											</table>
                                            {$codes->render()}
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

				<div aria-hidden="true" class="modal modal-va-middle fade" id="readytopay" role="dialog" tabindex="-1">
					<div class="modal-dialog modal-xs">
						<div class="modal-content">
							<div class="modal-heading">
								<a class="modal-close" data-dismiss="modal">×</a>
								<h2 class="modal-title">Now connecting you to Alipay...</h2>
							</div>
							<div class="modal-inner">
								<p id="title">Processing...</p>
							</div>
						</div>
					</div>
				</div>

				<div aria-hidden="true" class="modal modal-va-middle fade" id="alipay" role="dialog" tabindex="-1">
					<div class="modal-dialog modal-xs">
						<div class="modal-content">
							<div class="modal-heading">
								<a class="modal-close" data-dismiss="modal">×</a>
								<h2 class="modal-title">Please use the Alipay app to scan and pay：</h2>
							</div>
							<div class="modal-inner">
								<p id="title">You can tap on the QR code to be automatically redirected to Alipay</p>
								<p id="divide">-------------------------------------------------------------</p>
								<p id="qrcode"></p>
								<p id="info"></p>
							</div>

							<div class="modal-footer">
								<p class="text-right"><button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal" id="alipay_cancel" type="button">Cancel</button></p>
							</div>
						</div>
					</div>
				</div>

                {include file='dialog.tpl'}
			</div>
		</section>
	</div>
</main>







{include file='user/footer.tpl'}


<script>

    $(document).ready(function () {
        $('#cz').click(function(){
            $('#myForm').submit();
        })
        $("#code-update").click(function () {
            $.ajax({
                type: "POST",
                url: "code",
                dataType: "json",
                data: {
                    code: $("#code").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    }
                },
                error: function (jqXHR) {
                    $("#result").modal();
                    $("#msg").html("error：" + jqXHR.status);
                }
            })
        })

        $("#urlChange").click(function () {
            $.ajax({
                type: "GET",
                url: "code/f2fpay",
                dataType: "json",
                data: {
                    time: timestamp
                },
                success: function (data) {
                    if (data.ret) {
                        $("#readytopay").modal();
                    }
                }

            })
        });

        $("#readytopay").on('shown.bs.modal', function () {
            $.ajax({
                type: "POST",
                url: "code/f2fpay",
                dataType: "json",
                data: {
                    amount: $("#type").find("option:selected").val()
                },
                success: function (data) {
                    $("#readytopay").modal('hide');
                    if (data.ret) {
                        $("#qrcode").html(data.qrcode);
                        $("#info").html("Ammount："+data.amount+" rmb");
                        $("#alipay").modal();
                    } else {
                        $("#result").modal();
                        $("#msg").html(data.msg);
                    }
                },
                error: function (jqXHR) {
                    $("#readytopay").modal('hide');
                    $("#result").modal();
                    $("#msg").html(data.msg+"  error");
                }
            })
        });


        timestamp = {time()};


        function f(){
            $.ajax({
                type: "GET",
                url: "code_check",
                dataType: "json",
                data: {
                    time: timestamp
                },
                success: function (data) {
                    if (data.ret) {
                        clearTimeout(tid);
                        $("#alipay").modal('hide');
                        $("#result").modal();
                        $("#msg").html("Success！");
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    }
                }
            });
            tid = setTimeout(f, 1000); //循环调用触发setTimeout
        }
        setTimeout(f, 1000);
    })
</script>

