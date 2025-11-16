<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</div>
<footer class="footer">
	<!-- Start Middle Top -->
	<div class="footer-middle">
		<div class="fix-layout">
			<div class="row">
				<div class="col-lg-8 col-md-6 col-12">
					<!-- Single Widget -->
					<div class="f-about single-footer">
						<div class="logo">
							<a href="/"><img src="${pageContext.request.contextPath }/resources/images/logo/logobk.svg"
								alt="Logo"></a>
						</div>
						<ul class="contact-address">
							<li><span>우편번호 </span> 47246</li>
							<li><span>주소 </span> 부산 부산진구 동천로 109, 삼한골든게이트 7층</li>
						</ul>
						<p>Copyright(c) JobGo. All rights reserved.</p>
					</div>
					<!-- End Single Widget -->
				</div>
			</div>
		</div>
	</div>
	<!--/ End Footer Middle -->
	<%-- <!-- Start Footer Bottom -->
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
	End Footer Middle --%>
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