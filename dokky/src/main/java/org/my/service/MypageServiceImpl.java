package org.my.service;
	import java.util.List;

import org.my.domain.BoardVO;
import org.my.domain.Criteria;
import org.my.domain.MemberVO;
import org.my.domain.ReplyPageDTO;
import org.my.domain.ReplyVO;
import org.my.mapper.MypageMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.security.crypto.password.PasswordEncoder;
	import org.springframework.stereotype.Service;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MypageServiceImpl implements MypageService {

	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Override
	public MemberVO getMyInfo(String userId) {

		log.info("get MemberVO");

		return mapper.getMyInfo(userId);
	}
	
	@Override
	public boolean updateMyInfo(MemberVO board) {

		log.info("updateMyInfo......" + board); 

		boolean updateResult = mapper.updateMyInfo(board) == 1; 
		
		return updateResult;
	}
	@Override
	public String getMemberPW(String userId) {

		log.info("getMemberPW");

		return mapper.getMemberPW(userId);
	}
	
	@Override
	public boolean updateMyPassword(String userId, String userPw) {
		
		log.info("updateMyPassword1");
		
		boolean updateResult = mapper.updateMyPassword(userId,userPw) == 1; 
		
		return updateResult;
	}
	@Override
	public List<BoardVO> getMyBoardList(Criteria cri) {

		log.info("getMyBoardList with criteria: " + cri);

		return mapper.getMyBoardList(cri);
	}
	
	@Override
	public int getMyBoardCount(Criteria cri) {

		log.info("getMyBoardCount");
		
		return mapper.getMyBoardCount(cri);
	}
	
	@Override
	 public List<ReplyVO> getMyReplylist(Criteria cri) {
	       
		log.info("getMyReplylist with criteria: " + cri);
		
	    return mapper.getMyReplylist(cri); 
	 }
	
	@Override
	public int getMyReplyCount(Criteria cri) {

		log.info("getMyReplyCount");
		
		return mapper.getMyReplyCount(cri);
	}
	
	@Override
	public int getScrapCnt(int num, String userId) {
		
		log.info("getScrapCnt");
		
		int getResult = mapper.getScrapCnt(num,userId); 
		
		return getResult;
	}
	
	
	@Override
	public boolean insertScrapData(int num, String userId) {
		
		log.info("insertScrapData");
		
		boolean inserResult = mapper.insertScrapData(num,userId) == 1; 
		
		return inserResult;
	}
	
	
}

