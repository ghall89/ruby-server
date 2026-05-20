<script lang="ts">
	import { api, type Post, type User, type Reply } from '$lib/api';
	import { authState } from '$lib/auth.svelte';

	import ReplyForm from '$lib/components/reply-form.svelte';
	import ReplyNode from '$lib/components/reply-node.svelte';

	let { id }: { id: string } = $props();

	let post: Post | null = $state(null);
	let poster: User | null = $state(null);
	let replies: Reply[] = $state([]);
	let error = $state('');

	async function load() {
		try {
			const data = await api.getPost(id);
			post = data.post;
			poster = data.poster;
			replies = data.replies;
		} catch (err: any) {
			error = err.message;
		}
	}

	$effect(() => {
		id;
		load();
	});

	async function deletePost() {
		if (!confirm('Delete this post?')) return;
		try {
			await api.deletePost(id);
			goto('/');
		} catch (err: any) {
			error = err.message;
		}
	}
</script>

<section class="container mt-5">
	{#if error}
		<div class="alert alert-danger">{error}</div>
	{:else if post}
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h1>{post.title}</h1>
			{#if authState.user && post.user_id === authState.user.id}
				<div class="d-flex gap-2">
					<a href={'#/posts/' + id + '/edit'} class="btn btn-outline-secondary">Edit</a>
					<button class="btn btn-outline-danger" onclick={deletePost}>Delete</button>
				</div>
			{/if}
		</div>

		{#if poster}
			<p class="text-muted">by: {poster.username}</p>
		{/if}
		<p>{post.body}</p>
		<a href="#/" class="text-muted">← Back to posts</a>

		<hr class="my-4" />
		<h2 class="mb-3">Replies</h2>

		<ReplyForm postId={post.id} parentId={null} onReply={load} />

		{#if replies.length === 0}
			<p class="text-muted">No replies!</p>
		{:else}
			{#each replies as reply (reply.id)}
				<ReplyNode {reply} onNewReply={load} />
			{/each}
		{/if}
	{:else}
		<p class="text-muted">Loading...</p>
	{/if}
</section>
