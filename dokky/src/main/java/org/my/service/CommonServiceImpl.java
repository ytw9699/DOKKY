package org.my.service;
	import java.util.ArrayList;
	import java.util.Iterator;
	import java.util.List;
	import javax.servlet.http.Cookie;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import org.my.domain.AuthVO;
	import org.my.domain.BoardVO;
	import org.my.domain.Criteria;
	import org.my.domain.MemberVO;
	import org.my.domain.VisitCountVO;
	import org.my.domain.alarmVO;
	import org.my.domain.noteVO;
	import org.my.mapper.CommonMapper;
	import org.my.security.domain.CustomUser;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
	import org.springframework.security.core.Authentication;
	import org.springframework.security.core.GrantedAuthority;
	import org.springframework.security.core.authority.SimpleGrantedAuthority;
	import org.springframework.security.core.context.SecurityContextHolder;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CommonServiceImpl implements CommonService {

	@Setter(onMethod_ = @Autowired)
	private CommonMapper mapper;
	
	@Override 
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {  
		
		log.info("/logout"); 
		
		if(authentication != null) {
			//log.info(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
			SecurityContextHolder.getContext().setAuthentication(null);//인증 풀기
		}
		
		request.getSession().invalidate();//세션무효화

		Cookie JSESSIONID = new Cookie("JSESSIONID", null);

		JSESSIONID.setMaxAge(0);

		response.addCookie(JSESSIONID);//쿠키 삭제
	}
	
	@Override
	public List<BoardVO> getRealtimeBoardList() {

		log.info("getRealtimeBoardList: ");

		return mapper.getRealtimeBoardList();
	}
	@Override
	public List<BoardVO> getMonthlyBoardList() {

		log.info("getMonthlyBoardList: ");

		return mapper.getMonthlyBoardList();
	}
	@Override
	public List<BoardVO> getDonationBoardList() {

		log.info("getDonationBoardList: ");

		return mapper.getDonationBoardList();
	}
	
	@Override
	public boolean getNicknameCheckedVal(String inputNickname, String userId) {
		
		log.info("getNicknameCheckedVal");
		
		if(userId != null) {
			
			if(inputNickname.equals(mapper.getNickname(userId))) {
				log.info("return false");
				return false;
			}
		}
		
		log.info(mapper.getNicknameCheckedVal(inputNickname));
		log.info("return false2");
		
		return mapper.getNicknameCheckedVal(inputNickname) == 1;
	}
	
	@Override 
	public boolean getIdCheckedVal(String profileId) {

		log.info("getIdCheckedVal...");
		
		return mapper.getIdCheckedVal(profileId) == 1;
	}

	@Transactional
	@Override 
	public boolean updateLoginDate(String userName) {
		
		log.info("updateLoginDate..."); 
		
		return mapper.updatePreLoginDate(userName) == 1 && mapper.updatelastLoginDate(userName) == 1;
	}
	
	@Override 
	public boolean insertVisitor(VisitCountVO vo) {  

		log.info("insertVisitor..." + vo); 
		 
		return mapper.insertVisitor(vo) == 1 ;
	}
	
	@Override 
	public int getVisitTodayCount() {
		
		log.info("getVisitTodayCount..."); 
		
		return mapper.getVisitTodayCount();
	}
	
	@Override 
	public int getVisitTotalCount() {
		
		log.info("getVisitTotalCount..."); 
		
		return mapper.getVisitTotalCount();
	}
	
	@Override 
	public int getAllAlarmCount(Criteria cri) {
		log.info("getAllAlarmCount");
		
		return mapper.getAllAlarmCount(cri);
	}
	
	@Override 
	public int getAlarmCountRead(Criteria cri) {
		log.info("getAlarmCountRead");
		
		return mapper.getAlarmCountRead(cri);
	}
	@Override 
	public int getAlarmCountNotRead(String userId) {
		log.info("getAlarmCountNotRead");
		
		return mapper.getAlarmCountNotRead(userId);
	}
	
	@Override 
	public String getNoteCount(String userId) {
		log.info("getNoteCount");
		
		return mapper.getNoteCount(userId);
	}
	
	@Override 
	public String getChatCount(String userId) {
		log.info("getChatCount");
		
		return mapper.getChatCount(userId);
	}
	
	@Override
	public List<alarmVO> getAllAlarmList(Criteria cri){
		log.info("getAllAlarmList");
		
		return mapper.getAllAlarmList(cri);
	}
	
	@Override
	public List<alarmVO> getAlarmListRead(Criteria cri){
		log.info("getAlarmListRead");
		
		return mapper.getAlarmListRead(cri);
	}
	
	@Override
	public List<alarmVO> getAlarmListNotRead(Criteria cri){
		log.info("getAlarmListNotRead");
		
		return mapper.getAlarmListNotRead(cri);
	}
	
	
	@Override
	public boolean deleteAllAlarm(Long alarmNum) {

		log.info("remove...." + alarmNum);

		return mapper.deleteAllAlarm(alarmNum) == 1;
	}
	
	@Override
	public boolean deleteMyNote(Long note_num) {

		log.info("deleteMyNote...." + note_num);

		return mapper.deleteMyNote(note_num) == 1;
	}
	
	@Override 
	public int insertAlarm(alarmVO vo) {  

		log.info("insertAlarm..." + vo); 
		 
		return mapper.insertAlarm(vo) ;
	}
	
	@Override
	public int updateAlarmCheck(String alarmNum){
		log.info("updateAlarmCheck");
		
		return mapper.updateAlarmCheck(alarmNum);
	}
	
	@Override
	public int updateFromNote(Long note_num){
		log.info("updateFromNote");
		
		return mapper.updateFromNote(note_num);
	}
	
	@Override
	public int updateToNote(Long note_num){
		log.info("updateToNote");
		
		return mapper.updateToNote(note_num);
	}
	
	@Override
	public int updateNoteCheck(String note_num){
		log.info("updateNoteCheck");
		
		return mapper.updateNoteCheck(note_num);
	}
	
	@Override 
	public noteVO getDetailNotepage(Long note_num) {
		
		log.info("getDetailNotepage");
		
		return mapper.getDetailNotepage(note_num);
	}
	
	@Override 
	public int getEnabled(String userId){  

		log.info("getEnabled : " + userId); 
		
		return mapper.getEnabled(userId);
	}
	
	@Override 
	public boolean setAuthentication(MemberVO memberVO, boolean checkAuth){  
		
		log.info("setAuthentication");
		
		List<AuthVO> AuthList = memberVO.getAuthList();//사용자의 권한 정보만 list로 가져온다
		
		List<GrantedAuthority> roles = new ArrayList<>(1);// 인증해줄 권한 리스트를 만든다
		
		Iterator<AuthVO> it = AuthList.iterator();
		
		if(checkAuth == false) {//권한 체크를 안한다면
			
			while (it.hasNext()) {
				AuthVO authVO = it.next(); 
				roles.add(new SimpleGrantedAuthority(authVO.getAuth()));// 가져온 사용자의 권한을 리스트에 담아준다
	        }
			
		}else{//권한 체크를 한다면
			
			while (it.hasNext()) {
				
				AuthVO authVO = it.next(); 
				
				String auth = authVO.getAuth();
				
				if(auth.equals("ROLE_LIMIT")) {
					return false; 
				}
				
				roles.add(new SimpleGrantedAuthority(auth));// 가져온 사용자의 권한을 리스트에 담아준다
	        }
		}

		Authentication auth = new UsernamePasswordAuthenticationToken(new CustomUser(memberVO), null, roles);//사용자의 인증객체를 만든다
		
		SecurityContextHolder.getContext().setAuthentication(auth);//Authentication 인증객체를 SecurityContext에 보관
		
		return true;
	}
	
	@Override 
	public String getAccessKey() {
		
		log.info("getAccessKey");
		
		return mapper.getAccessKey();
	}
	
	@Override 
	public String getSecretKey() {
		
		log.info("getSecretKey");
		
		return mapper.getSecretKey();
	}
	
	@Override 
	public int getFromNoteCount(Criteria cri) {
		log.info("getFromNoteCount");
		
		return mapper.getFromNoteCount(cri);
	}
	
	@Override 
	public int getToNoteCount(Criteria cri) {
		log.info("getToNoteCount");
		
		return mapper.getToNoteCount(cri);
	}
	
	@Override 
	public int getMyNoteCount(Criteria cri) {
		log.info("getMyNoteCount");
		
		return mapper.getMyNoteCount(cri);
	}
	
	@Override 
	public int insertNote(noteVO vo) {  

		log.info("insertNote : " + vo); 
		
		return mapper.insertNote(vo) ;
	}
	
	@Override
	public List<noteVO> getFromNoteList(Criteria cri){
		log.info("getFromNoteList");
		
		return mapper.getFromNoteList(cri);
	}
	
	@Override
	public List<noteVO> getMyNoteList(Criteria cri){
		log.info("getMyNoteList");
		
		return mapper.getMyNoteList(cri);
	}
	
	@Override
	public List<noteVO> getToNoteList(Criteria cri){
		log.info("getToNoteList");
		
		return mapper.getToNoteList(cri);
	}
}
