<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<style>
	/* 전체 테이블 */
	table{
		max-width:500px;
		margin:0 auto;
	}
	
	/* 프로필 이미지 사진 미리보기 이미지*/
	.uploadImage{
		width:100px;
		height:100px;
		border-radius:50px;
		border:1px solid #ccc;
	}
	
	#emailCodeWrap, #acceptEmail, #codeWrap{
		display:none;
	}
</style>
<!-- view/user/join.jsp -->
<form id="joinForm" action="${path}/user/joinPost" method="POST" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<th colspan="2"><h1>JOIN PAGE</h1></th>
		</tr>
		<tr>
			<td>프로필 이미지</td>
			<td align="center">
				<img src="${path}/resources/img/profile.jpg" id="uploadImage" class="uploadImage"/> <br/>
				<input type="file" id="profileImage" name="profileImage" accept="image/*" />
			</td>
		</tr>
		<tr>
			<td>아이디(e-mail)</td>
			<td>
				<input type="text" name="u_id" id="u_id" autocomplete="off"/>
				<button type="button" id="acceptEmail">이메일 인증</button>
				<!-- 검증 결과를 출력할 박스모델 -->
				<div class="result"></div>
				<div id="emailCodeWrap">
					<input type="text" id="emailCode"/>
					<button type="button" id="emailAcceptBtn">인증완료</button>
				</div>
			</td>
		</tr>
		<!-- 비밀번호 -->
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="u_pw" id="u_pw" />
				<div class="result"></div>
			</td>
		</tr>
		<!-- 비밀번호 확인-->
		<tr>
			<td>비밀번호 확인</td>
			<td>
				<input type="password" name="re_pw" id="re_pw" />
				<div class="result"></div>
			</td>
		</tr>
		<!-- 이름 -->
		<tr>
			<td>이름(한글2~6자)</td>
			<td>
				<input type="text" name="u_name" id="u_name"/>
				<div class="result"></div>
			</td>
		</tr>
		<!-- 생년월일 -->
		<tr>
			<td>생년월일(ex-19951231)</td>
			<td>
				<input type="text" name="u_birth" id="u_birth"/>
				<div class="result"></div>
			</td>
		</tr>
		<!-- 주소 -->
		<tr>
			<td>주소</td>
			<td>
				<div>
					<input type="text" readonly name="u_post" id="u_post" class="addr" placeholder="우편번호"/>
					<input type="button" value="주소찾기" onclick="daumPostCode();"/>
				</div>
				<input type="text" readonly name="u_addr" id="u_addr" class="addr" placeholder="주소"/>
				<input type="text" name="u_addr_detail" id="u_addr_detail"
					class="addr" placeholder="상세주소"/>
			</td>
		</tr>
		<!-- 전화번호  -->
		<tr>
			<td>전화번호(-제외)</td>
			<td>
				<div id="phoneWrap">		
					<input type="text" id="u_phone" name="u_phone"/>
					<input type="button" id="sendSMS" value="인증코드 전송"/>
					<div class="result"></div>
				</div>
				<div id="codeWrap">
					<input type="text" id="code"/>
					<input type="button" id="acceptCode" value="인증" />
				</div>
			</td>
		</tr>
		<!-- 개인정보처리방침 -->
		<!-- https://www.privacy.go.kr -->
		<tr>
			<td colspan="2">
				<h4>개인정보처리방침</h4>
				<textarea readonly cols=50 rows=5>당신의 개인정보는 언제든지 회사에서 팔아먹을 수 있으니 조심</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<label>
					<input type="checkbox" name="u_info" id="u_ifno" value="y" />
					개인정보 이용 동의
				</label>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="button" id="joinBtn" value='회원가입'/>
			</th>
		</tr>
	</table>	
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function daumPostCode(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
            let fullAddr = "";  // 최종주소
            let extraAddr = ""; // 조합형주소
            let postCode = "";  // 우편번호
            if(data.userSelectedType == "R"){
            	// 도로명 주소
            	fullAddr = data.roadAddress;
            	// 법정 동명
            	if(data.bname !== ''){
            		extraAddr += data.bname;
            	}
            	
            	// 빌딩 이름
            	if(data.buildingName !== ''){
            		extraAddr += extraAddr !== '' ? ', ' + data.buildingName : data.buildingName
            	}
            	
            	fullAddr += (extraAddr !== '') ? '('+extraAddr+')' : '';
            }else {
            	// 지번 주소
            	fullAddr = data.jibunAddress;
            }
            document.querySelector("#u_post").value = data.zonecode;            
            document.querySelector("#u_addr").value = fullAddr;
            document.querySelector("#u_addr_detail").focus();
        }
    }).open();
}
</script>
<script>
	var imgTemp = document.querySelector(".uploadImage").src;
	
	document.querySelector("#profileImage").addEventListener("change",function(e){
		let files = e.target.files[0];
		// 선택된 파일이 존재하고
		// 선택된 파일의 미디어 타입이 image/로 시작하면 == 이미지 파일
		if(files != null && files.type.startsWith("image/")){
			console.log(files);
			let path = window.URL.createObjectURL(files);
			document.querySelector(".uploadImage").src = path;
		}else{
			alert("이미지를 선택해주세요");
			document.querySelector(".uploadImage").src = imgTemp;
			e.target.value = "";
		}
	});
	
	// 정규 표현식 검사
	// checkRegex(메세지를 출력할 요소,검사할 값,비교할 정규표현식,출력할 메세지,비동기 통신 함수)
	function checkRegex(elP,valP,regexP,messageP,ajaxP) {
		// 정규표현식 패턴과 사용자가 작성한 내용의 패턴이 일치하지 않음
		if(regexP.test(valP) === false){
			showMessage(elP,messageP,false);
			return false;
		}else if(regexP.test(valP) !== false && ajaxP === null){
			showMessage(elP,messageP,true);
			return true;
		}else{
			if(ajaxP !== null){
				ajaxP(elP);
			}
		}
	}
	
	// 검증 여부에 따른 결과 메세지 출력
	// (출력할 요소,메세지,검사 성공 여부)
	function showMessage(elP,messageP,isCheck){
		let html = document.createElement("span");
		let styles = 'margin-left:5px; font-size:12px;';
		styles += isCheck ? "color:green;" : "color:red;";
		html.setAttribute('style', styles);
		html.innerText = messageP;
		if (elP.firstElementChild) elP.removeChild(elP.firstElementChild);
		elP.appendChild(html);
	}
	
	// u_id 검증 완료 여부
	var boolUid = false;
	// 이메일 정규 표현식
	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	// 입력태그에 값이 작성 될때
	document.querySelector("#u_id").addEventListener("input",(e)=>{
		let tempVal = e.target.value;
		let elP = e.target.parentElement.querySelector(".result");
		let message = "올바른 이메일 형식이 아닙니다.";
		document.querySelector("#acceptEmail").style.display = "none";
		boolUid = checkRegex(elP,tempVal,regexEmail,message,checkUidAjax);
	});
	
	// 서버에 등록된 이메일 인지 확인 - ajax
	function checkUidAjax(elP){
		$.ajax({
			type : "GET",
			url : "${path}/user/uidCheck",
			data : {
				u_id : document.querySelector("#u_id").value
			},
			dataType : "json",
			success : (result)=>{
				console.log(result);
				boolUid = result;
				showMessage(
					elP,
					boolUid ? "사용가능한 아이디 입니다." : "이미 존재하는 아이디입니다.",
					boolUid
				);
				
				if(result){
					document.querySelector("#acceptEmail").style.display = "inline-block";
				}else{
					document.querySelector("#acceptEmail").style.display = "none";
				}
			}
		})
	} // checkUidAjax end
	
	// 인증 이메일 확인
	var emailCode = ''; // 발송된 인증 코드 저장

	document.querySelector("#acceptEmail").addEventListener("click",(e)=>{
		e.target.setAttribute("disabled");
		
		let xhr = new XMLHttpRequest();
		let u_id = document.querySelector("#u_id").value;
		let url = '${path}/checkEmail?u_id='+u_id;
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState === XMLHttpRequest.DONE) {
				if(xhr.status === 200){
					console.log(xhr.responseText);
					if(xhr.responseText != null){
						emailCode = xhr.responseText;
						alert('메일 발송 완료! 메일을 확인해주세요');
						document.querySelector("#emailCodeWrap").style.display = "block";
					}
				}
			}
		}
		
		xhr.open('GET',url,true);
		xhr.send();
	});
	
	// 인증 코드 확인 완료 여부 저장
	var boolEmailCode = false;
	document.querySelector("#emailAcceptBtn").addEventListener("click",()=>{
		let userCode = document.querySelector("#emailCode").value;
		if(emailCode == userCode){
			// 일치
			alert("이메일 인증이 완료되었습니다.");
			boolEmailCode = true;
			document.querySelector("#emailCodeWrap").style.display = "none";
		}else{
			// 불일치
			boolEmailCode = false;
			alert("인증코드를 다시 한번 확인해 주세요.");
		}
	});
	
	// 비밀번호 확인
	var boolPassword = false;
	// 특수문자 포함 비밀번호
	var regexPass = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	
	document.querySelector("#u_pw").addEventListener("input",(e)=>{
		let valP = e.target.value;
		let elP = e.target.parentElement.querySelector(".result");
		let message = "특수문자 포함 영문/숫자 조합 8~16이내 작성"
		boolPassword = checkRegex(elP,valP,regexPass,message,null);
	});
	
	// 비밀번호 일치 여부 체크
	var boolPassCheck = false;
	document.querySelector("#re_pw").addEventListener("input",(e)=>{
		let valP = e.target.value;
		let originalVal = document.querySelector("#u_pw").value;
		let elP = e.target.parentElement.querySelector(".result");
		if(boolPassword){
			if(originalVal == valP){
				boolPassCheck = true;
				message = "비밀번호가 일치합니다.";
			}else{
				boolPassCheck = false;
				message = "비밀번호가 일치하지 않습니다.";
			}
		}else{
			boolPassCheck = false;
			message = "비밀번호를 먼저 확인해주세요.";
		}
		showMessage(elP,message,boolPassCheck);
	});
	
	// 이름 작성란 확인
	var boolName = false;
	var regexName = /^[\uac00-\ud7a3]{2,6}$/;
	document.querySelector("#u_name").addEventListener("input",(e)=>{
		let valP = e.target.value;
		let elP = e.target.parentElement.querySelector(".result");
		let message = "2~6자이내 한글로 작성";
		boolName = checkRegex(elP,valP,regexName,message,null);
	});
	
	// 생년월일
	var boolBirth = false;
	var regexBirth = /^[0-9]{4}[0-9]{2}[0-9]{2}$/;
	document.querySelector("#u_birth").addEventListener("input",(e)=>{
		let tempVal = e.target.value;
		let elP = e.target.parentElement.querySelector(".result");
		let message = "마 생년월일로 적어라 19990909";
		boolBirth = checkRegex(elP,tempVal,regexBirth,message,null);
	});
	
	// 전화번호 검증
	var boolPhone = false;
	// mobile - 표시 없이 숫자만
	var regexMobile = /^[0-9]{2,3}?[0-9]{3,4}?[0-9]{4}$/;
	document.querySelector("#u_phone").addEventListener("input",(e)=>{
		let tempVal = e.target.value;
		let elP = e.target.parentElement.querySelector(".result");
		let message = " - 제외 숫자만 입력해주세요";
		boolPhone = checkRegex(elP,tempVal,regexMobile,message,null);
		if(boolPhone){
			document.querySelector("#sendSMS").disabled = false;
		}
	});
	
	// 인증 코드 발송
	var code = ""; // 발송된 SMS 코드 저장
	// 인증 완료 여부
	var boolSMS = false;
	document.querySelector("#sendSMS").addEventListener("click",(e)=>{
		if(!boolPhone){
			alert("전화번호확인해라");
			document.querySelector("#u_phone").focus();
		}else{
			e.target.disabled = true;
			let xhr = new XMLHttpRequest();
			let phoneNumber = document.querySelector('#u_phone').value;
			let url = "${path}/sendSMS?userPhoneNumber="+phoneNumber;
			
			xhr.onreadystatechange = function() {
		        if (xhr.readyState === XMLHttpRequest.DONE) {
		            if (xhr.status === 200) {
		                var result = xhr.responseText;
		                console.log(result);
		                document.querySelector("#codeWrap").style.display = 'block';
		                var resultMap = JSON.parse(result);
		                console.log(resultMap);
		                code = resultMap.code;
		            } 
		        }
		    };
		    
		    xhr.open("POST",url,true);
		    xhr.send();
		}
	});
	
	// 문자 발신 코드 확인
	document.querySelector("#acceptCode").addEventListener("click",(e)=>{
		let userCode = document.querySelector("#code").value;
		if(code != "" && userCode.length != 0 && code == userCode){
			alert("인증 완료");
			boolSMS = true;
			document.querySelector("#sendSMS").value = "인증완료";
			document.querySelector("#codeWrap").style.display = 'none';
			document.querySelector("#code").value = "";
		}else{
			alert("발송된 인증코드를 다시 확인해주세요");
			document.querySelector("#code").focus();
		}
	});
	
	// 확인 단계
	document.querySelector("#joinBtn").addEventListener("click",()=>{
		// 전송 검증 완료 여부 확인
		
		// u_post, u_addr, u_addr_detail
		let addrObj = null;			// 미작성된 주소 입력 태그
		let boolAddress = null;		// 주소 정상 작성 여부 저장
		let hint = "";				// 어디가 미작성인지 hint
		
		document.querySelectorAll(".addr").forEach((item)=>{
			let val = item.value;
			console.log(val);
			boolAddress = (val !== '') ? true : false;
			if(!boolAddress){
				addrObj = item;
				console.log(addrObj);
				hint = item.getAttribute("placeholder");
				return false;
			}
		});
		
		boolEmailCode = true;
		boolSMS = true;
		
		if(!boolUid){
			// 아이디 유효성 검사 및 중복 검사 완료 여부
			alert("아이디를 확인해주세요");
			document.querySelector("#u_id").focus();
		}else if(!boolEmailCode){
			// 본인 이메일 검증 여부
			alert("이메일 인증을 완료해 주세요.");
			document.querySelector("#emailCode").focus();
		}else if(!boolPassword){
			alert("비밀번호를 확인해주세요");
			document.querySelector("#u_pw").focus();
		}else if(!boolPassCheck){
			alert("비밀번호 일치여부를 확인해주세요");
			document.querySelector("#re_pw").focus();
		}else if(!boolName){
			alert("이름 입력란을 확인해주세요");
			document.querySelector("#u_name").focus();
		}else if(!boolBirth){
			alert("생년월일을 확인해주세요");
			document.querySelector("#u_birth").focus();
		}else if(!boolAddress){
			alert(hint+"를 확인해주세요");
			document.querySelector(addrObj).focus();				
		}else if(!boolPhone){
			alert("전화번호를 확인해주세요");
			document.querySelector("#u_phone").focus();
		}else if(!boolSMS){
			alert("전화번호 인증을 완료해주세요");
			document.querySelector("#code").focus();
		}else if(!$("#u_info").is(":checked")){
			alert("개인정보 이용동의를 확인해주세요");
			document.querySelector("#u_info").focus();
		}else {
			document.querySelector("#joinForm").submit();
		}
	});
	
	
	
</script>
</body>
</html>