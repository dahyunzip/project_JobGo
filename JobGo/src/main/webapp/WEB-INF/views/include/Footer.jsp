<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</div>
<footer class="footer">
	<!-- Start Middle Top -->
	<div class="footer-middle">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-6 col-12">
					<!-- Single Widget -->
					<div class="f-about single-footer">
						<div class="logo">
							<a href="/"><img src="${pageContext.request.contextPath }/resources/images/logo/logo.svg"
								alt="Logo"></a>
						</div>
						<p>Start building your creative website with our awesome
							template Massive.</p>
						<ul class="contact-address">
							<li><span>Address:</span> 555 Wall Street, USA, NY</li>
							<li><span>Email:</span> example@apus.com</li>
							<li><span>Call:</span> 555-555-1234</li>
						</ul>
					</div>
					<!-- End Single Widget -->
				</div>
				<div class="col-lg-4 col-12">
					<div class="row">
						<div class="col-lg-4 col-md-6 col-12">
							<!-- Single Widget -->
							<div class="single-footer f-link">
								<h3>For Candidates</h3>
								<ul>
									<li><a href="#">User Dashboard</a></li>
									<li><a href="#">CV Packages</a></li>
									<li><a href="#">Jobs Featured</a></li>
									<li><a href="#">Jobs Urgent</a></li>
									<li><a href="#">Candidate List</a></li>
									<li><a href="#">Candidates Grid</a></li>
								</ul>
							</div>
							<!-- End Single Widget -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/ End Footer Middle -->
	<!-- Start Footer Bottom -->
	<div class="footer-bottom">
		<div class="container">
			<div class="inner">
				<div class="row">
					<div class="col-lg-6 col-md-6 col-12">
						<div class="left">
							<p>
								Designed and Developed by<a href="https://graygrids.com/" rel="nofollow" target="_blank">GrayGrids</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Footer Middle -->
</footer>
<!--/ End Footer Area -->

<!-- ========================= scroll-top ========================= -->
<a href="#" class="scroll-top btn-hover"> <i class="lni lni-chevron-up"></i></a>

<!-- ========================= JS here ========================= -->
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/wow.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/tiny-slider.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/glightbox.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript">
	//====== Clients Logo Slider
	tns({
		container : '.client-logo-carousel',
		slideBy : 'page',
		autoplay : true,
		autoplayButtonOutput : false,
		mouseDrag : true,
		gutter : 15,
		nav : false,
		controls : false,
		responsive : {
			0 : {
				items : 1,
			},
			540 : {
				items : 2,
			},
			768 : {
				items : 3,
			},
			992 : {
				items : 4,
			},
			1170 : {
				items : 6,
			}
		}
	});
	//========= glightbox
	GLightbox({
		'href' : 'https://www.youtube.com/watch?v=cz4z8CyvDas',
		'type' : 'video',
		'source' : 'youtube', //vimeo, youtube or local
		'width' : 900,
		'autoplayVideos' : true,
	});
</script>
</body>
</html>