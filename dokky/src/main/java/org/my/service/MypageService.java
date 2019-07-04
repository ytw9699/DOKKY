package org.my.service;
	import java.util.List;
	import org.my.domain.BoardVO;
	import org.my.domain.Criteria;
	import org.my.domain.MemberVO;
	import org.my.domain.ReplyVO;

public interface MypageService {

	public MemberVO getMyInfo(String userId);

	public boolean updateMyInfo(MemberVO vo);

	public String getMemberPW(String userId);

	public boolean updateMyPassword(String userId, String userPw);

	public List<BoardVO> getMyBoardList(Criteria cri);

	public int getMyBoardCount(Criteria cri);

	public List<ReplyVO> getMyReplylist(Criteria cri);

	public int getMyReplyCount(Criteria cri);

	public boolean insertScrapData(int num, String userId);

	public int getScrapCnt(int num, String userId);
	
}
