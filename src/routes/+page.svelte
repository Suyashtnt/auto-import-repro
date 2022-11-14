<script lang="ts">
	// no type error here
	testStore.set(5);

	// type error here
	$: console.log($testStore);
</script>

<!-- type error here as well -->
<h1>count: {$testStore}</h1>

<h2>Look at src/lib/testStore.ts for the stores src</h2>
