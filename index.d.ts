import MovToMp4 from "./index";

interface IMovToMp4 {
  convertMovToMp4: (uri: string, newUri: string) => Promise<string>;
}
declare const MovToMp4: IMovToMp4;

export default MovToMp4;
