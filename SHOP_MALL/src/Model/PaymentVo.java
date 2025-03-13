package Model;
import java.sql.Timestamp;

public class PaymentVo {
	private String paymentid; // 결제 ID
	private String userid; // 사용자 ID
	private int orderid; // 주문 ID
	private int amount; // 결제 금액
	private String paymentMethod; // 결제 방법
	private String paymentStatus; // 결제 상태
	private Timestamp paymentDate; // 결제 일시

	public String getPaymentId() {
		return paymentid;
	}

	public void setPaymentId(String paymentId) {
		this.paymentid = paymentId;
	}

	public String getUserId() {
		return userid;
	}

	public void setUserId(String userId) {
		this.userid = userId;
	}

	public int getOrderId() {
		return orderid;
	}

	public void setOrderId(int orderId) {
		this.orderid = orderId;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public Timestamp  getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Timestamp  paymentDate) {
		this.paymentDate = paymentDate;
	}

}
