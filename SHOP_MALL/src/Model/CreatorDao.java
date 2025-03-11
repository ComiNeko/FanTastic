package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

public class CreatorDao {

	//전체 작가 조회
	public List<CreatorVo> getSelect() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from NEW_AUTHOR order by authorid desc";

		List<CreatorVo> list = new ArrayList<CreatorVo>();

		try {
			conn = DBManager.getInstance().getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CreatorVo vo = new CreatorVo();
				vo.setAuthorid(rs.getInt("authorid"));
				vo.setAuthorname(rs.getString("authorname"));
				vo.setAuthorinfo(rs.getString("authorinfo"));
				vo.setAuthorimg1(rs.getString("authorimg1"));
				vo.setAuthorimg2(rs.getString("authorimg2"));
				vo.setAuthorimg3(rs.getString("authorimg3"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.getInstance().close(rs, pstmt, conn);
		}
		return list;
	}// select
	
	//특정 작가 조회
		public List<CreatorVo> getSearch(int authorid) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String sql = "SELECT "
		               + " A.authorid, A.authorname, A.authorinfo, A.authorimg1, A.authorimg2, A.authorimg3, "
		               + " P.productid, P.productname, P.productprice, P.productstock, P.productinfo "
		               + " FROM NEW_AUTHOR A "
		               + " LEFT JOIN NEW_PRODUCTS P ON A.authorid = P.authorid "
		               + " WHERE A.authorid = ?";

			List<CreatorVo> list = new ArrayList<CreatorVo>();

			try {
				conn = DBManager.getInstance().getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, authorid);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					CreatorVo vo = new CreatorVo();
					// 작가 정보
		            vo.setAuthorid(rs.getInt("authorid"));
		            vo.setAuthorname(rs.getString("authorname"));
		            vo.setAuthorinfo(rs.getString("authorinfo"));
		            vo.setAuthorimg1(rs.getString("authorimg1"));
		            vo.setAuthorimg2(rs.getString("authorimg2"));
		            vo.setAuthorimg3(rs.getString("authorimg3"));

		            // 상품 정보 (있을 때만)
		            vo.setProductid(rs.getInt("productid")); // 상품이 없으면 0
		            vo.setCategoryid(rs.getInt("categoryid"));
		            vo.setProductName(rs.getString("productname"));
		            vo.setProductPrice(rs.getInt("productprice"));
		            vo.setProductStock(rs.getInt("productstock"));
		            vo.setProductInfo(rs.getString("productinfo"));
		            vo.setProductImage(rs.getString("productimage"));
		            vo.setCreatedAt(rs.getString("createdAt"));
		            vo.setUpdatedAt(rs.getString("updatedAt"));
					list.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBManager.getInstance().close(rs, pstmt, conn);
			}
			return list;
		}
		
}//dao
