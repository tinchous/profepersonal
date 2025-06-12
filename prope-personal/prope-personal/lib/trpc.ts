import { initTRPC } from '@trpc/server';
import { createNextApiHandler } from '@trpc/server/adapters/next';

const t = initTRPC.create();

export const router = t.router({
  hello: t.procedure.query(() => {
    return '¡Hola desde PEO v.3!';
  }),
});

export type Router = typeof router;

export const trpcHandler = createNextApiHandler({
  router,
  createContext: () => ({}),
});
