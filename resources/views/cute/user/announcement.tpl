





{include file='user/main.tpl'}



	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">Announcements</h1>
				<h5 class="content-heading">If you have any questions, please check the announcements first!</h5>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="ui-card-wrap">
					
						<div class="col-lg-12 col-md-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<div class="card-table">
											<div class="table-responsive">
												<table class="table">
													<tr>
														<th>ID</th>														
														<th>Content</th>
													</tr>
													{foreach $anns as $ann}
														<tr>
															<td>#{$ann->id}</td>															
															<td>{$ann->content}</td>
														</tr>
													{/foreach}
												</table>
											</div>
										</div>
									</div>
									
								</div>
							</div>
							
							
						
						{include file='dialog.tpl'}
						
					</div>
						
					
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}



