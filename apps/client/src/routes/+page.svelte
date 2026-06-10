<script lang="ts">
	import { api, type Post } from '../lib/api';
	import PostList from '$lib/components/post-list.svelte';

	let posts: Post[] = $state([]);
	let loading = $state(true);
	let error = $state('');

	$effect(() => {
		api
			.getPosts()
			.then((data) => {
				posts = data;
			})
			.catch((err) => {
				error = err.message;
			})
			.finally(() => {
				loading = false;
			});
	});
</script>

<section class="container mt-5">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<span></span>
		<a href="#/posts/new" class="btn btn-primary">New Post</a>
	</div>

	{#if loading}
		<p class="text-muted">Loading...</p>
	{:else if error}
		<div class="alert alert-danger">{error}</div>
	{:else}
		<PostList {posts} />
	{/if}
</section>
