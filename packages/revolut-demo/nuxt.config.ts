import { defineNuxtConfig } from "nuxt/config";
import { zksyncInMemoryNode, zksyncSepoliaTestnet } from "viem/chains";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2024-04-03",
  devtools: { enabled: true },
  modules: ["@nuxt/icon", "@vueuse/nuxt", "radix-vue/nuxt", "@nuxt/eslint", "@pinia/nuxt", "@nuxtjs/tailwindcss", "@nuxtjs/google-fonts"],
  ssr: false,
  googleFonts: {
    families: {
      Inter: [300, 400, 500, 600, 700],
    },
  },
  app: {
    head: {
      bodyAttrs: {
        class: "bg-khaki"
      }
    }
  },
  runtimeConfig: {
    public: {
      aaveAddress: "0xE90E12261CCb0F3F7976Ae611A29e84a6A85f424", // Rich Account 9
      revolutDemoDeployerKey: "0x3d3cbc973389cb26f657686445bcc75662b415b656078503592ac8c1abb8810e", // Rich Account 0
      network: zksyncInMemoryNode,
      session: "0x476F23ef274F244282252341792c8a610feF78ee",
      passkey: "0x455e8d86DC6728396f8d3B740Fc893F4E20b25Dc",
      accountFactory: "0x04FaEd9dCb8d7731d89fe94eb3cc8a29E0e10204",
      accountImplementation: "0x6cd5A2354Be0E656e7A1E94F1C0570E08EC4789B",
    }
  },
  $production: {
    runtimeConfig: {
      public: {
        aaveAddress: "0x34847471630EEAB49c07Eb2EdABE773F4A0eaDf7",
        revolutDemoDeployerKey: "0x89b96a981c0943d67a01cfc73f3f07c96d7da5dd0ccfef4e65366cb25f62e80c",
        network: zksyncSepoliaTestnet,
        session: "0xE1c71303ED0215A0c2789F7f6e5C0A83D62740e0",
        passkey: "0x5a80c5F9A978847491080578b5f756770bDF0F0F",
        accountFactory: "0x47FCE4A53efb7F98B2b7cf5014d4D71EE1564379",
        accountImplementation: "0xf2F56D1005b35E1160E577D98eA7353F1aBBabB3",
      }
    }
  }
});
