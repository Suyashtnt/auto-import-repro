import { sveltekit } from '@sveltejs/kit/vite';
import AutoImport from 'unplugin-auto-import/vite'
import type { UserConfig } from 'vite';

const config: UserConfig = {
	plugins: [
		AutoImport({
			include: [
				/\.[tj]sx?$/,
				/\.svelte$/,
			],
			dts: 'src/auto-imports.d.ts',
			imports: [
				'svelte',
				'svelte/store'
			],
			dirs: [
				'src/lib',
			],
			eslintrc: {
				enabled: true
			}
		}),
		sveltekit()
	]
};

export default config;
