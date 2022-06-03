import { emptySplitApi } from "../../config/empty-slice";
import { createConsumer } from "@rails/actioncable";
import { Serie } from "@nivo/line";
import differenceInMinutes from "date-fns/differenceInMinutes";
export interface LiveMetric {
  serie: Serie;
  perMinuteSerie: Serie;
  minValue: number;
  maxValue: number;
}
const extendedApi = emptySplitApi.injectEndpoints({
  endpoints: (build) => ({
    live: build.query<LiveMetric, string>({
      queryFn: function (arg, queryApi, extraOptions, baseQuery) {
        return {
          data: {
            serie: {
              id: arg,
              data: [],
            },
            perMinuteSerie: {
              id: arg + "_PM",
              data: [],
            },
            minValue: 0,
            maxValue: 0,
          },
        };
      },
      async onCacheEntryAdded(
        arg,
        { updateCachedData, cacheDataLoaded, cacheEntryRemoved }
      ) {
        const consumer = createConsumer();
        try {
          await cacheDataLoaded;
          const listener = (metricData: {
            name: string;
            value: string;
            timestamp: string;
            uid: string;
          }) => {
            updateCachedData((draft) => {
              if (draft.minValue === 0 || draft.maxValue === 0) {
                draft.minValue = +metricData.value * 0.9;
                draft.maxValue = +metricData.value * 1.1;
              }
              if (metricData.name.endsWith("_PM")) {
                draft.perMinuteSerie.data.push({
                  x: metricData.timestamp,
                  y: +metricData.value,
                });
              } else {
                draft.serie.data.push({
                  x: metricData.timestamp,
                  y: +metricData.value,
                });
              }
            });
          };
          consumer.subscriptions.create(
            { channel: "MetricChannel", name: arg },
            { received: listener }
          );
        } catch (e) {
          console.log(e);
        }
      },
    }),
  }),
  overrideExisting: false,
});

export const { useLiveQuery } = extendedApi;
