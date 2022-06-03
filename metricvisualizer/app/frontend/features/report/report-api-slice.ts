import { emptySplitApi } from "../../config/empty-slice";

const extendedApi = emptySplitApi.injectEndpoints({
  endpoints: (build) => ({
    report: build.query({
      query: () => "report",
    }),
  }),
  overrideExisting: false,
});

export const { useReportQuery } = extendedApi;
