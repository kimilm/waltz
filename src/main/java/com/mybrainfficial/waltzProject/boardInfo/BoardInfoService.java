package com.mybrainfficial.waltzProject.boardInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

@Service
public class BoardInfoService {
	
	@Autowired
	private BoardInfoDAO boardInfoDAO;
	
	public BoardInfoVO selectBoardinfo(final BoardInfoVO vo) throws DataAccessException {
		return boardInfoDAO.selectBoardInfo(vo);
	}
	
	public List<BoardInfoVO> selectListBoardInfo(final BoardInfoVO vo) throws DataAccessException {
		return boardInfoDAO.selectListBoardInfo(vo);
	}
	
	public List<PostVO> selectListPost(final BoardInfoVO vo) throws DataAccessException {
		return boardInfoDAO.selectListPost(vo);
	}
	
	public int insertBoardInfo (final BoardInfoVO vo) throws DataAccessException {
		return boardInfoDAO.insertBoardInfo(vo);
	}
	
	public int updateBoardInfo (final BoardInfoVO vo) throws DataAccessException {
		return boardInfoDAO.updateBoardInfo(vo);
	}
}
