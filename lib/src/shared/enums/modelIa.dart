enum ModelIA {
  horizonBeta('openrouter/horizon-beta'),
  deepSeekR1T2Chimera('tngtech/deepseek-r1t2-chimera:free'),
  gemma3n2b('google/gemma-3n-e2b-it:free'),
  llama3_1NemotronUltra('nvidia/llama-3.1-nemotron-ultra-253b-v1:free');

  final String path;

  const ModelIA(this.path);
}