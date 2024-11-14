import type { AuthServerRpcSchema, ExtractReturnType, SessionPreferences } from "zksync-sso/client-auth-server";

export const constructReturn = (address: `0x${string}`, chainId: number, session?: { sessionKey: `0x${string}`; sessionConfig: SessionPreferences }): ExtractReturnType<"eth_requestAccounts", AuthServerRpcSchema> => {
  return {
    account: {
      address,
      activeChainId: chainId,
      session: !session ? undefined : session,
    },
    chainsInfo: supportedChains.map((chain) => ({
      id: chain.id,
      capabilities: {
        paymasterService: {
          supported: true,
        },
        atomicBatch: {
          supported: true,
        },
        auxiliaryFunds: {
          supported: true,
        },
      },
      contracts: contractsByChain[chain.id],
    })),
  };
};
