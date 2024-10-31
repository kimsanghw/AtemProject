package FrontController.vo;

public class SearchVO {
    private int no;
    private String board;
    private String name;
    private String title;
    private String rdate;
    private int hit;

    public SearchVO(int no, String board, String name, String title, String rdate, int hit) {
        this.no = no;
        this.board = board;
        this.name = name;
        this.title = title;
        this.rdate = rdate;
        this.hit = hit;
    }

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getBoard() {
		return board;
	}

	public void setBoard(String board) {
		this.board = board;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}
}
