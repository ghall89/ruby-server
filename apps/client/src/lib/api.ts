import type { User, Reply, Post } from './models/api-types';
import { PUBLIC_API_URL } from '$env/static/public';

async function req(method: string, path: string, data?: Record<string, string>): Promise<any> {
	console.log('PUBLIC_API_URL: ', PUBLIC_API_URL);
	const init: RequestInit = { method, credentials: 'include' };
	if (data) {
		init.headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
		init.body = new URLSearchParams(data).toString();
	}
	const res = await fetch(`${PUBLIC_API_URL}${path}`, init);
	if (!res.ok) {
		const json = await res.json().catch(() => ({}));
		throw new Error(json.error || `HTTP ${res.status}`);
	}
	return res.status === 204 ? null : res.json();
}

export const api = {
	login: (username: string, password: string, rememberMe: boolean): Promise<User> =>
		req('POST', '/login', { username, password, remember_me: rememberMe ? '1' : '0' }),

	signup: (username: string, password: string): Promise<User> =>
		req('POST', '/signup', { username, password }),

	logout: (): Promise<null> => req('POST', '/logout'),

	getPosts: (): Promise<Post[]> => req('GET', '/posts'),

	getPost: (id: string | number): Promise<{ post: Post; poster: User; replies: Reply[] }> =>
		req('GET', `/posts/${id}`),

	createPost: (title: string, body: string): Promise<Post> =>
		req('POST', '/posts', { title, body }),

	updatePost: (id: string | number, body: string): Promise<Post> =>
		req('PATCH', `/posts/${id}`, { body }),

	deletePost: (id: string | number): Promise<null> => req('DELETE', `/posts/${id}`),

	createReply: (
		postId: string | number,
		parentId: string | number | null,
		body: string
	): Promise<Reply> =>
		req('POST', '/replies', {
			post_id: String(postId),
			body,
			...(parentId != null ? { parent_id: String(parentId) } : {})
		})
};
