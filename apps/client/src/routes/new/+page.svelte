<script lang="ts">
	import { api } from '$lib/api';
	import { goto } from '$app/navigation';
	import { resolve } from '$app/paths';

	let title = $state('');
	let body = $state('');
	let error = $state('');
	let submitting = $state(false);

	async function handleSubmit(e: Event) {
		e.preventDefault();
		submitting = true;
		error = '';
		try {
			const post = await api.createPost(title, body);
			goto(resolve(`/posts/${post.id}`));
		} catch (err: any) {
			error = err.message;
		} finally {
			submitting = false;
		}
	}
</script>

<section class="container mt-5">
	<h1 class="mb-4">New Post</h1>
	{#if error}
		<div class="alert alert-danger">{error}</div>
	{/if}
	<form onsubmit={handleSubmit}>
		<div class="mb-3">
			<label for="title" class="form-label">Title</label>
			<input class="form-control" id="title" bind:value={title} />
		</div>
		<div class="mb-3">
			<label for="body" class="form-label">Body</label>
			<textarea class="form-control" id="body" bind:value={body} rows="5"></textarea>
		</div>
		<div class="d-flex gap-2">
			<button type="submit" class="btn btn-primary" disabled={submitting}>Create Post</button>
			<a href="#/" class="btn btn-outline-secondary">Cancel</a>
		</div>
	</form>
</section>
