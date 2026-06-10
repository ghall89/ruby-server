export interface User {
	id: number;
	username: string;
}

export interface Post {
	id: number;
	user_id: number;
	title: string;
	body: string;
}

export interface Reply {
	id: number;
	user_id: number;
	post_id: number;
	parent_id: number | null;
	body: string;
	children: Reply[];
}
