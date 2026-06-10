<script lang="ts">
	import type { Reply } from '../api';
	import ReplyForm from './reply-form.svelte';
	import ReplyNode from './reply-node.svelte';

	let {
		reply,
		onNewReply
	}: {
		reply: Reply;
		onNewReply: () => void;
	} = $props();

	let showReplyForm = $state(false);
</script>

<div class="mt-3">
	<p>{reply.body}</p>
	<button class="btn btn-link btn-sm p-0" onclick={() => (showReplyForm = !showReplyForm)}>
		{showReplyForm ? 'Cancel' : 'Reply'}
	</button>

	{#if showReplyForm}
		<div class="mt-2">
			<ReplyForm
				postId={reply.post_id}
				parentId={reply.id}
				onReply={() => {
					showReplyForm = false;
					onNewReply();
				}}
			/>
		</div>
	{/if}

	{#if reply.children?.length > 0}
		<div class="ms-4 border-start ps-3">
			{#each reply.children as child (child.id)}
				<ReplyNode reply={child} {onNewReply} />
			{/each}
		</div>
	{/if}
</div>
